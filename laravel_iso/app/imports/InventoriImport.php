<?php

namespace App\Imports;

use Carbon\Carbon;
use App\Models\Gedung;
use App\Models\Ruangan;
use App\Models\Inventori;
use Illuminate\Support\Collection;
use Maatwebsite\Excel\Concerns\ToCollection;
use Maatwebsite\Excel\Concerns\WithStartRow;

class InventoriImport implements ToCollection, WithStartRow
{

    public function collection(Collection $rows)
    {
        // $gedung_id = Gedung::where('gedung', $col[13])->first()->id_gedung;
        // $ruangan_id = Ruangan::where('ruangan', $col[14])->first()->id_ruangan;

        // $kondisi_barang = 'B';


        foreach ($rows as $key => $row) {

            $tanggal = Carbon::parse(strtotime($row[4]))->format('Y-m-d');

            if ($row[9] != '') {
                $kondisi_barang = 'B';
            } elseif ($row[10] != '') {
                $kondisi_barang = 'RR';
            } elseif ($row[11] != '') {
                $kondisi_barang = 'RB';
            } else {
                $kondisi_barang = 'B';
            }

            if ($row[12] != '') {
                $keberadaan_barang = 'BD';
            } elseif ($row[13] != '') {
                $keberadaan_barang = 'BTD';
            } elseif ($row[14] != '') {
                $keberadaan_barang = 'Berlebih';
            } else {
                $keberadaan_barang = 'BD';
            }

            if ($row[15] != '') {
                $pelabelan_kodefikasi = 'sudah';
            } elseif ($row[16] != '') {
                $pelabelan_kodefikasi = 'belum';
            } else {
                $pelabelan_kodefikasi = 'belum';
            }

            if ($row[15] != '') {
                $status_psp = 'sudah';
            } elseif ($row[16] != '') {
                $status_psp = 'belum';
            } else {
                $status_psp = 'belum';
            }

            if ($row[1] != null) {
                Inventori::create([
                    'uraian_akun'           => $row[1],
                    'kode_barang'           => $row[2],
                    'nama_barang'           => $row[3],
                    'tahun_perolehan'       => $tanggal,
                    'nup'                   => $row[5],
                    'merk_type'             => $row[6],
                    'kuantitas'             => $row[7],
                    'nilai_bmn'             => $row[8],
                    'kondisi_barang'        => $kondisi_barang,
                    'keberadaan_barang'     => $keberadaan_barang,
                    'pelabelan_kodefikasi'  => $pelabelan_kodefikasi,
                    'pengguna'              => $row[17],
                    'gedung_id'             => 1,
                    'ruangan_id'            => 1,
                    'status_psp'            => $status_psp,
                    'keterangan'            => $row[22],
                ]);
            }
        }
    }

    public function startRow(): int
    {
        return 12;
    }
}
