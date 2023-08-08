<table id="dataTable" class="table table-bordered" cellspacing="0">
    <thead>
        <tr></tr>
        <tr>
            <td colspan="17" style="text-align: center;"><b>KERTAS KERJA INVENTARISASI BARANG MILIK NEGARA SELAIN KENDARAAN BERMOTOR</b></td>
        </tr>
        <tr>
            <td colspan="17" style="text-align: center;"><b>PADA SATUAN KERJA POLITEKNIK NEGERI INDRAMAYU</b></td>
        </tr>
        <tr><td colspan="17" style="text-align: center;"><b>PER {{ $tanggal }}</b></td></tr>
        <tr></tr>
        <tr></tr>
        <tr></tr>
        <tr></tr>
        <tr>
            <th style="text-align: center; border: 1px solid black;" rowspan="2"><b>No</b></th>
            <th style="text-align: center; border: 1px solid black;" rowspan="2"><b>Uraian Akun</b></th>
            <th style="text-align: center; border: 1px solid black;" rowspan="2"><b>Kode Barang</b></th>
            <th style="text-align: center; border: 1px solid black;" rowspan="2"><b>Nama Barang</b></th>
            <th style="text-align: center; border: 1px solid black;" rowspan="2"><b>Tahun Perolehan</b></th>
            <th style="text-align: center; border: 1px solid black;" rowspan="2"><b>NUP</b></th>
            <th style="text-align: center; border: 1px solid black;" rowspan="2"><b>Merek/Tipe</b></th>
            <th style="text-align: center; border: 1px solid black;" rowspan="2"><b>Kuantitas</b></th>
            <th style="text-align: center; border: 1px solid black;" rowspan="2"><b>Nilai BMN</b></th>
            <th style="text-align: center; border: 1px solid black;" colspan="3"><b>Kondisi Barang</b></th>
            <th style="text-align: center; border: 1px solid black;" colspan="3"><b>Keberadaan Barang</b></th>
            <th style="text-align: center; border: 1px solid black;" colspan="2"><b>Pelabelan Kodefikasi</b></th>
            <th style="text-align: center; border: 1px solid black;" rowspan="2"><b>Nama Pegawai Pengguna Barang</b></th>
            <th style="text-align: center; border: 1px solid black;" rowspan="2"><b>Nama Gedung</b></th>
            <th style="text-align: center; border: 1px solid black;" rowspan="2"><b>Nama Ruangan</b></th>
            <th style="text-align: center; border: 1px solid black;" colspan="2"><b>Status PSP</b></th>
            <th style="text-align: center; border: 1px solid black;" rowspan="2"><b>Keterangan</b></th>
        </tr>
        <tr>
            <td style="text-align: center; border: 1px solid black;"><b>B</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>RR</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>RB</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>BD</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>BTD</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>Berlebih</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>Sudah</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>Belum</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>Sudah</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>Belum</b></td>
        </tr>
        <tr>
            <td style="text-align: center; border: 1px solid black;"><b>1</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>2</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>3</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>4</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>5</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>6</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>7</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>8</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>9</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>10</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>11</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>12</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>13</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>14</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>15</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>16</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>17</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>18</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>19</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>20</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>21</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>22</b></td>
            <td style="text-align: center; border: 1px solid black;"><b>23</b></td>
        </tr>
    </thead>
    <tbody>
        @foreach ($data as $index => $value)
            <tr>
                <td style="text-align: center; border: 1px solid black;">{{ $index+1 }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->uraian_akun }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->kode_barang }}</td>
                <td style="border: 1px solid black;">{{ $value->nama_barang }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->tahun_perolehan }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->nup }}</td>
                <td style="border: 1px solid black;">{{ $value->merk_type }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->kuantitas }}</td>
                <td style="border: 1px solid black;">{{ $value->nilai_bmn }}</td>
                <td style="text-align: center; border: 1px solid black;">
                    @if ($value->kondisi_barang == 'B')
                        {{ $value->kondisi_barang }}
                    @endif
                </td>
                <td style="text-align: center; border: 1px solid black;">
                    @if ($value->kondisi_barang == 'RR')
                        {{ $value->kondisi_barang }}
                    @endif
                </td>
                <td style="text-align: center; border: 1px solid black;">
                    @if ($value->kondisi_barang == 'RB')
                        {{ $value->kondisi_barang }}
                    @endif
                </td>
                <td style="text-align: center; border: 1px solid black;">
                    @if ($value->keberadaan_barang == 'BD')
                        {{ $value->keberadaan_barang }}
                    @endif
                </td>
                <td style="text-align: center; border: 1px solid black;">
                    @if ($value->keberadaan_barang == 'BTD')
                        {{ $value->keberadaan_barang }}
                    @endif
                </td>
                <td style="text-align: center; border: 1px solid black;">
                    @if ($value->keberadaan_barang == 'Berlebih')
                        {{ $value->keberadaan_barang }}
                    @endif
                </td>
                <td style="text-align: center; border: 1px solid black;">
                    @if ($value->pelabelan_kodefikasi == 'sudah')
                        {{ $value->pelabelan_kodefikasi }}
                    @endif
                </td>
                <td style="text-align: center; border: 1px solid black;">
                    @if ($value->pelabelan_kodefikasi == 'belum')
                        {{ $value->pelabelan_kodefikasi }}
                    @endif
                </td>
                <td style="border: 1px solid black;">{{ $value->pengguna }}</td>
                <td style="border: 1px solid black;">{{ $value->gedung }}</td>
                <td style="border: 1px solid black;">{{ $value->ruangan }}</td>
                <td style="text-align: center; border: 1px solid black;">
                    @if ($value->status_psp == 'sudah')
                        {{ $value->status_psp }}
                    @endif
                </td>
                <td style="text-align: center; border: 1px solid black;">
                    @if ($value->status_psp == 'belum')
                        {{ $value->status_psp }}
                    @endif
                </td>
                <td style="border: 1px solid black;">{{ $value->keterangan }}</td>
            </tr>
        @endforeach
    </tbody>
</table>