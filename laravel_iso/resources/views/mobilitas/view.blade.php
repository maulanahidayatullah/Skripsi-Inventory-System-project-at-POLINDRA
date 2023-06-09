@extends('layouts.layout')
@section('content')
<title>Riwayat Mobilitas</title>

<div class="card-header py-3">
  <h6 class="m-0 font-weight-bold text-dark">Riwayat Mobilitas</h6>
</div>
<div class="card-body">
  <div class="table-responsive">
    {{-- <button class="btn btn-success" data-toggle="modal" data-target="#tambah">Tambah Data</button>
      <br>
      <br> --}}
      <table id="dataTable" class="table table-bordered" cellspacing="0">
          <thead>
            <tr>
                <th rowspan="2">No</th>
                <th rowspan="2">User</th>
                <th rowspan="2">Nama Barang</th>
                <th rowspan="2">Kode Barang</th>
                <th rowspan="2">NUP</th>
                <th rowspan="2">Tanggal</th>
                <th colspan="2" class="text-center text-white bg-danger">Sebelum</th>
                <th colspan="2" class="text-center text-white bg-success">Sesudah</th>
            </tr>
            <tr>
                <th class="text-center text-danger">Gedung</th>
                <th class="text-center text-danger">Ruangan</th>
                <th class="text-center text-success">Gedung</th>
                <th class="text-center text-success">Ruangan</th>
            </tr>
          </thead>
          <tbody>
            @foreach ($logMobilitas as $i => $u)
            <tr class="data-row">
              <td class="align-middle iteration">{{ ++$i }}</td>
              <td class="align-middle nama">{{ $u->User->Pegawai->nama }}</td>
              <td class="align-middle nama">{{ $u->MobilitasSebelum->Inventori->nama_barang }}</td>
              <td class="align-middle tanggal">{{ $u->MobilitasSebelum->Inventori->kode_barang }}</td>
              <td class="align-middle tanggal">{{ $u->MobilitasSebelum->Inventori->nup }}</td>
              <td class="align-middle tanggal">{{ $u->created_at }}</td>
              <td class="align-middle sebelum_gedung">{{ $u->MobilitasSebelum->Gedung->gedung }}</td>
              <td class="align-middle sebelum_ruangan">{{ $u->MobilitasSebelum->Ruangan->ruangan }}</td>
              <td class="align-middle sesudah_gedung">{{ $u->MobilitasSesudah->Gedung->gedung }}</td>
              <td class="align-middle sesudah_ruangan">{{ $u->MobilitasSesudah->Ruangan->ruangan }}</td>
            </tr>
            @endforeach
          </tbody>
        </table>
  </div>
</div>

@endsection