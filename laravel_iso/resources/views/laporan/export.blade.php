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
            <th style="text-align: center; border: 1px solid black;" rowspan="2">No</th>
            <th style="text-align: center; border: 1px solid black;" rowspan="2">Uraian<br>Akun</th>
            <th style="text-align: center; border: 1px solid black;" rowspan="2">Kode Barang</th>
            <th style="text-align: center; border: 1px solid black;" rowspan="2">Nama Barang</th>
            <th style="text-align: center; border: 1px solid black;" rowspan="2">Tahun Perolehan</th>
            <th style="text-align: center; border: 1px solid black;" rowspan="2">NUP</th>
            <th style="text-align: center; border: 1px solid black;" rowspan="2">Merek/Tipe</th>
            <th style="text-align: center; border: 1px solid black;" rowspan="2">Kuantitas</th>
            <th style="text-align: center; border: 1px solid black;" rowspan="2">Nilai BMN</th>
            <th style="text-align: center; border: 1px solid black;" colspan="3">Kondisi<br>Barang</th>
            <th style="text-align: center; border: 1px solid black;" colspan="3">Keberadaan Barang</th>
            <th style="text-align: center; border: 1px solid black;" colspan="2">Pelabelan<br>Kodefikasi</th>
            <th style="text-align: center; border: 1px solid black;" rowspan="2">Nama Pegawai<br>Pengguna Barang</th>
            <th style="text-align: center; border: 1px solid black;" rowspan="2">Nama Gedung</th>
            <th style="text-align: center; border: 1px solid black;" rowspan="2">Nama Ruangan</th>
            <th style="text-align: center; border: 1px solid black;" colspan="2">Status PSP</th>
            <th style="text-align: center; border: 1px solid black;" rowspan="2">Keterangan</th>
        </tr>
        <tr>
            <td style="text-align: center; border: 1px solid black;">B</td>
            <td style="text-align: center; border: 1px solid black;">RR</td>
            <td style="text-align: center; border: 1px solid black;">RB</td>
            <td style="text-align: center; border: 1px solid black;">BD</td>
            <td style="text-align: center; border: 1px solid black;">BTD</td>
            <td style="text-align: center; border: 1px solid black;">Berlebih</td>
            <td style="text-align: center; border: 1px solid black;">Sudah</td>
            <td style="text-align: center; border: 1px solid black;">Belum</td>
            <td style="text-align: center; border: 1px solid black;">Sudah</td>
            <td style="text-align: center; border: 1px solid black;">Belum</td>
        </tr>
        <tr>
            <td style="text-align: center; border: 1px solid black;">1</td>
            <td style="text-align: center; border: 1px solid black;">2</td>
            <td style="text-align: center; border: 1px solid black;">3</td>
            <td style="text-align: center; border: 1px solid black;">4</td>
            <td style="text-align: center; border: 1px solid black;">5</td>
            <td style="text-align: center; border: 1px solid black;">6</td>
            <td style="text-align: center; border: 1px solid black;">7</td>
            <td style="text-align: center; border: 1px solid black;">8</td>
            <td style="text-align: center; border: 1px solid black;">9</td>
            <td style="text-align: center; border: 1px solid black;">10</td>
            <td style="text-align: center; border: 1px solid black;">11</td>
            <td style="text-align: center; border: 1px solid black;">12</td>
            <td style="text-align: center; border: 1px solid black;">13</td>
            <td style="text-align: center; border: 1px solid black;">14</td>
            <td style="text-align: center; border: 1px solid black;">15</td>
            <td style="text-align: center; border: 1px solid black;">16</td>
            <td style="text-align: center; border: 1px solid black;">17</td>
            <td style="text-align: center; border: 1px solid black;">18</td>
            <td style="text-align: center; border: 1px solid black;">19</td>
            <td style="text-align: center; border: 1px solid black;">20</td>
            <td style="text-align: center; border: 1px solid black;">21</td>
            <td style="text-align: center; border: 1px solid black;">22</td>
            <td style="text-align: center; border: 1px solid black;">23</td>
        </tr>
    </thead>
    <tbody>
        @foreach ($data as $index => $value)
            <tr>
                <td style="text-align: center; border: 1px solid black;">{{ $index+1 }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->uraian_akun }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->kode_barang }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->nama_barang }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->tahun_perolehan }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->nup }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->merk_type }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->kuantitas }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->nilai_bmn }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->kondisi_barang }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->kondisi_barang }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->kondisi_barang }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->keberadaan_barang }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->keberadaan_barang }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->keberadaan_barang }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->pelabelan_kodefikasi }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->pelabelan_kodefikasi }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->pengguna }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->gedung }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->ruangan }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->status_psp }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->status_psp }}</td>
                <td style="text-align: center; border: 1px solid black;">{{ $value->keterangan }}</td>
            </tr>
        @endforeach
    </tbody>
</table>