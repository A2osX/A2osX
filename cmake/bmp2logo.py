#!/usr/bin/env python3
"""bmp2logo.py - Convert a 24-bit Windows BMP to A2osX S.BM PIX format.

Usage:  bmp2logo.py <input.bmp> <output.logo>

The output is a ProDOS PIC ($CB) file containing an 8-byte S.BM header
followed by nibble-packed 4bpp pixel data (2 pixels per byte).

Pixel packing:  byte[x/2] = (even_pixel & 0x0F) | (odd_pixel << 4)
Row order:      top-to-bottom  (BMP bottom-up storage is reversed)
Header layout:  F(1) RowBytes(1) W(2LE) H(2LE) MaskOfs(2LE)

Palette derived from BIN/BMP2PIX.S.txt PALETTE.RGB table (Apple II DLGR).
"""

import struct
import sys

# Apple II DLGR 16-color palette (R, G, B) — from BMP2PIX.S.txt
PALETTE = [
    (0x00, 0x00, 0x00),  # 0  BLACK
    (0x1F, 0x35, 0xD3),  # 1  DARK.BLUE
    (0x00, 0x76, 0x0C),  # 2  DARK.GREEN
    (0x07, 0xA8, 0xE0),  # 3  BLUE
    (0x62, 0x4C, 0x00),  # 4  BROWN
    (0x7E, 0x7E, 0x7E),  # 5  DARK.GRAY
    (0x43, 0xC8, 0x00),  # 6  LIGHT.GREEN
    (0x5D, 0xF7, 0x84),  # 7  AQUA
    (0x93, 0x0B, 0x7C),  # 8  RED
    (0xBB, 0x36, 0xFF),  # 9  PURPLE
    (0x9C, 0x9C, 0x9C),  # 10 LIGHT.GRAY
    (0xB5, 0xAF, 0xFF),  # 11 LIGHT.BLUE
    (0xF9, 0x56, 0x1D),  # 12 ORANGE
    (0xFF, 0x81, 0xEC),  # 13 PINK
    (0xDC, 0xCD, 0x16),  # 14 YELLOW
    (0xFF, 0xFF, 0xFF),  # 15 WHITE
]

S_BM_F_BBP4 = 0x04  # 4bpp nibble-packed format code


def nearest_color(r, g, b):
    best_idx = 0
    best_dist = 0x7FFFFFFF
    for idx, (pr, pg, pb) in enumerate(PALETTE):
        dist = (r - pr) ** 2 + (g - pg) ** 2 + (b - pb) ** 2
        if dist < best_dist:
            best_dist = dist
            best_idx = idx
    return best_idx


def convert(bmp_path, logo_path):
    data = open(bmp_path, "rb").read()

    if data[0:2] != b"BM":
        raise ValueError(f"{bmp_path}: not a BMP file")

    data_offset = struct.unpack_from("<I", data, 0x0A)[0]
    width = struct.unpack_from("<I", data, 0x12)[0]
    height = struct.unpack_from("<I", data, 0x16)[0]
    bpp = struct.unpack_from("<H", data, 0x1C)[0]

    if bpp != 24:
        raise ValueError(f"{bmp_path}: only 24bpp BMP supported (got {bpp}bpp)")

    # BMP rows are padded to 4-byte boundary; stored bottom-to-top
    bmp_row_bytes = (width * 3 + 3) & ~3
    out_row_bytes = (width + 1) // 2

    rows = []
    for row in range(height):
        bmp_row = height - 1 - row  # reverse: BMP bottom-up → top-down output
        base = data_offset + bmp_row * bmp_row_bytes
        out = bytearray(out_row_bytes)
        for x in range(width):
            b = data[base + x * 3]
            g = data[base + x * 3 + 1]
            r = data[base + x * 3 + 2]
            idx = nearest_color(r, g, b)
            byte_pos = x // 2
            if x % 2 == 0:
                out[byte_pos] = (out[byte_pos] & 0xF0) | (idx & 0x0F)
            else:
                out[byte_pos] = (out[byte_pos] & 0x0F) | ((idx << 4) & 0xF0)
        rows.append(out)

    # S.BM header: F(1) RowBytes(1) W(2LE) H(2LE) MaskOfs(2LE)
    header = struct.pack("<BBHHH", S_BM_F_BBP4, out_row_bytes, width, height, 0)

    with open(logo_path, "wb") as f:
        f.write(header)
        for row in rows:
            f.write(row)

    total = len(header) + len(rows) * out_row_bytes
    print(f"bmp2logo: {bmp_path} ({width}x{height} 24bpp) -> {logo_path} ({total} bytes)")


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print(f"Usage: {sys.argv[0]} <input.bmp> <output.logo>", file=sys.stderr)
        sys.exit(1)
    convert(sys.argv[1], sys.argv[2])
