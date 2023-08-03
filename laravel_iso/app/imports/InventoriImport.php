<?php

namespace App\Imports;

use App\Models\Gedung;
use App\Models\Inventori;
use App\Models\Ruangan;
use Carbon\Carbon;
use Maatwebsite\Excel\Concerns\ToModel;

class InventoriImport implements ToModel
{
    public function model(array $row)
    {
        $gedung_id = Gedung::where('gedung', $row[13])->first()->id_gedung;
        $ruangan_id = Ruangan::where('ruangan', $row[14])->first()->id_ruangan;

        return new Inventori([
            'uraian_akun'           => $row[1],
            'kode_barang'           => $row[2],
            'nama_barang'           => $row[3],
            'tahun_perolehan'       => Carbon::parse($row[4])->format('Y-m-d H:i'),
            'nup'                   => $row[5],
            'merk_type'             => $row[6],
            'kuantitas'             => $row[7],
            'nilai_bmn'             => $row[8],
            'kondisi_barang'        => $row[9],
            'keberadaan_barang'     => $row[10],
            'pelabelan_kodefikasi'  => $row[11],
            'pengguna'              => $row[12],
            'gedung_id'             => $gedung_id,
            'ruangan_id'            => $ruangan_id,
            'status_psp'            => $row[15],
            'keterangan'            => $row[16],
        ]);
    }
}
