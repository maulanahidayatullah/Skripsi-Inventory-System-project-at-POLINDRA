<?php

namespace App\Exports;

use DB;

use App\Models\Inventori;
use Carbon\Carbon;
use Illuminate\Contracts\View\View;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\FromView;

class LaporanExport implements FromView
{
    protected $filter;
    protected $value_1;
    protected $value_2;

    public function __construct($filter, $value_1, $value_2)
    {
        $this->filter = $filter;
        $this->value_1 = $value_1;
        $this->value_2 = $value_2;
    }

    public function view(): View
    {
        if ($this->filter === "gedung_ruangan") {
            if (!empty($this->value_2)) {
                $data = DB::table('inventori as inv')
                    ->join('gedung as gedung', 'inv.gedung_id', '=', 'gedung.id_gedung')
                    ->join('ruangan as ruangan', 'inv.ruangan_id', '=', 'ruangan.id_ruangan')
                    ->where('ruangan.id_ruangan', $this->value_2)
                    ->select()
                    ->get();
            } elseif (!empty($this->value_1)) {
                $data = DB::table('inventori as inv')
                    ->join('gedung as gedung', 'inv.gedung_id', '=', 'gedung.id_gedung')
                    ->join('ruangan as ruangan', 'inv.ruangan_id', '=', 'ruangan.id_ruangan')
                    ->where('gedung.id_gedung', $this->value_1)
                    ->get();
            }
        } elseif ($this->filter === "tahun") {
            $data = DB::table('inventori as inv')
                ->join('gedung as gedung', 'inv.gedung_id', '=', 'gedung.id_gedung')
                ->join('ruangan as ruangan', 'inv.ruangan_id', '=', 'ruangan.id_ruangan')
                ->whereBetween('inv.tahun_perolehan', [$this->value_1, $this->value_2])
                ->get();
        } else {
            $data = DB::table('inventori as inv')
                ->join('gedung as gedung', 'inv.gedung_id', '=', 'gedung.id_gedung')
                ->join('ruangan as ruangan', 'inv.ruangan_id', '=', 'ruangan.id_ruangan')
                ->get();
        }

        return view('laporan.export', [
            'tanggal' => Carbon::now()->toDateString(),
            'data' => collect($data)
        ]);
    }
}
