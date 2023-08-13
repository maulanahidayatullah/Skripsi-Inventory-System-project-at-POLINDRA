@extends('layouts.layout')
@section('content')
<title>Tambah Pengembalian</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>  
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
</div>
 <div class="row"> 
  <div class="col-xl-6 col-md-12 mb-4">
    <div class="card border-left-dark shadow h-100 py-2">
      <div class="card-body">
        <div class="row no-gutters align-items-center">
          <div class="col mr-2">
            <div class="text-xs font-weight-bold text-dark text-uppercase mb-1">Kode Peminjaman</div>
            <div class="h5 mb-0 font-weight-bold text-gray-800">{{$peminjaman[0]->kode_peminjaman}}</div>
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
  <h6 class="m-0 font-weight-bold text-dark">Detail Peminjaman</h6>
</div>
<div class="card-body">
  <div class="table-responsive">
    {{-- <button class="btn btn-success" data-toggle="modal" data-target="#tambah">Tambah Data</button>--}}
    {{-- <a href="/peminjaman/export_excel" class="btn btn-warning my-3" target="_blank">EXPORT EXCEL</a> --}}
    <form action="{{ url('/pengembalian/store') }}" method="post">
          @csrf
        <table id="dataTable" class="table table-bordered" cellspacing="0">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Nama Barang</th>
                    <th>Kode Barang</th>
                    <th>NUP</th>
                    <th>Kondisi Barang</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($peminjaman as $index => $value)
                    <tr>
                        <td>{{ $index + 1 }}</td>
                        <td>{{ $value->Inventori->nama_barang }}</td>
                        <td>{{ $value->Inventori->kode_barang }}</td>
                        <td>{{ $value->Inventori->nup }}</td>
                        <td>
                            <input type="hidden" name="user_id" value="{{ $value->user_id }}">
                            <input type="hidden" name="kode_peminjaman" value="{{ $value->kode_peminjaman }}">
                            <input type="hidden" name="peminjaman_id[{{ $index }}]" value="{{ $value->id }}">
                            <input type="hidden" name="inventori_id[{{ $index }}]" value="{{ $value->id }}">
                            <div class="form-group">
                                <label for="">Kondisi Barang</label>
                                <select class="myselect" name="kondisi_barang[{{ $index }}]" id="" style="width:100%" required>
                                    <option></option>
                                <option value="B">Benar</option>
                                <option value="RR">Rusak Ringan</option>
                                <option value="RB">Rusak Berat</option>
                                </select>
                            </div>
                        </td>
                    </tr>
                @endforeach
            </tbody>
        </table>
        <center><button type="submit" class="btn btn-primary">Selesai</button></center>
        <br><br>
    </form>
  </div>
</div>
  
@endsection