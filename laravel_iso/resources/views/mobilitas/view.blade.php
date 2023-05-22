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
                <th rowspan="2">Tanggal</th>
                <th colspan="2" class="text-center">Sebelum</th>
                <th colspan="2" class="text-center">Sesudah</th>
            </tr>
            <tr>
                <th>Gedung</th>
                <th>Ruangan</th>
                <th>Gedung</th>
                <th>Ruangan</th>
            </tr>
          </thead>
          <tbody>
            @foreach ($logMobilitas as $i => $u)
            <tr class="data-row">
              <td class="align-middle iteration">{{ ++$i }}</td>
              <td class="align-middle nama">{{ $u->User->Pegawai->nama }}</td>
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