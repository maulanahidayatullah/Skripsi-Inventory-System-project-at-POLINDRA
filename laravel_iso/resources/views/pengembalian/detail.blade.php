@extends('layouts.layout')
@section('content')
<title>Detail Peminjaman</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>  
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
</div>
 <div class="row"> 
  {{-- <div class="col-xl-6 col-md-12 mb-4">
    <div class="card border-left-dark shadow h-100 py-2">
      <div class="card-body">
        <div class="row no-gutters align-items-center">
          <div class="col mr-2">
            <div class="text-xs font-weight-bold text-dark text-uppercase mb-1">Total yang di pinjam</div>
          </div>
          <div class="col-auto">
            <i class="fas fa-box fa-2x text-gray-300"></i>
          </div>
        </div>
      </div>
    </div>
  </div> --}}
  <div class="col-xl-6 col-md-12 mb-4">
    <div class="card border-left-dark shadow h-100 py-2">
      <div class="card-body">
        <div class="row no-gutters align-items-center">
          <div class="col mr-2">
            <div class="text-xs font-weight-bold text-dark text-uppercase mb-1">Kode Peminjaman</div>
            <div class="h5 mb-0 font-weight-bold text-gray-800">{{$pengembalian[0]->kode_peminjaman}}</div>
          </div>
          <div class="col-auto">
            <i class="fas fa-file fa-2x text-gray-300"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
 </div>
 <div class="card shadow mb-4">

<div class="card-header py-3">
  <h6 class="m-0 font-weight-bold text-dark">Detail Pengembalian</h6>
</div>
<div class="card-body">
  <div class="table-responsive">
    {{-- <button class="btn btn-success" data-toggle="modal" data-target="#tambah">Tambah Data</button>--}}
    {{-- <a href="/peminjaman/export_excel" class="btn btn-warning my-3" target="_blank">EXPORT EXCEL</a> --}}
    <table id="dataTable" class="table table-bordered" cellspacing="0">
        <thead>
            <tr>
                <th>No</th>
                <th>Nama Barang</th>
                <th>Kode Barang</th>
                <th>NUP</th>
                <th class="text-white bg-danger">Kondisi Barang Sebelum Dipinjam</th>
                <th class="text-white bg-success">Kondisi Barang Setelah Dipinjam</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($pengembalian as $index => $value)
                <tr>
                    <td>{{ $index + 1 }}</td>
                    <td>{{ $value->Peminjaman->Inventori->nama_barang }}</td>
                    <td>{{ $value->Peminjaman->Inventori->kode_barang }}</td>
                    <td>{{ $value->Peminjaman->Inventori->nup }}</td>
                    <td>
                      @if ($value->Peminjaman->kondisi_barang === 'B')
                        <b>Benar</b>
                      @elseif($value->Peminjaman->kondisi_barang === 'RR')
                        <b>Rusak Ringan</b>
                      @else
                        <b>Rusak Berat</b>
                      @endif
                    </td>
                    <td>
                      @if ($value->kondisi_barang=== 'B')
                        <b>Benar</b>
                      @elseif($value->kondisi_barang === 'RR')
                        <b>Rusak Ringan</b>
                      @else
                        <b>Rusak Berat</b>
                      @endif
                    </td>
                    {{-- <td>{{ $value->Inventori->nama_barang }}</td>
                    <td>{{ $value->Inventori->kode_barang }}</td>
                    <td>{{ $value->Inventori->nup }}</td>
                    <td>{{ $value->Inventori->Gedung->gedung }}</td>
                    <td>{{ $value->Inventori->Ruangan->ruangan }}</td> --}}
                </tr>
            @endforeach
        </tbody>
    </table>
  </div>
</div>
  
@endsection