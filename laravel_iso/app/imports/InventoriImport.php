<?php

namespace App\Imports;

use App\Models\Inventori;
use Illuminate\Support\Facades\Hash;
use Maatwebsite\Excel\Concerns\ToModel;

class InventoriImport implements ToModel
{
    public function model(array $row)
    {
        return new Inventori([
            'uraian_akun'           => $row[1],
            'kode_barang'           => $row[2],
            'nama_barang'           => $row[3],
            'tahun_perolehan'       => $row[4],
            'nup'                   => $row[5],
            'merk_type'             => $row[6],
            'kuantitas'             => $row[7],
            'nilai_bmn'             => $row[8],
            'pengguna'              => $row[9],
            'kondisi_barang'        => $row[10],
            'keberadaan_barang'     => $row[11],
            'pelabelan_kodefikasi'  => $row[12],
        ]);
    }
}
