@extends('layouts.layout')
@section('content')
<title>Data Peminjaman</title>
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
            <div class="text-xs font-weight-bold text-dark text-uppercase mb-1">Total Peminjaman</div>
            <div class="h5 mb-0 font-weight-bold text-gray-800">{{$peminjaman}}</div>
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
  <h6 class="m-0 font-weight-bold text-dark">Data Peminjaman</h6>
</div>
<div class="card-body">
  <div class="table-responsive">
    {{-- <button class="btn btn-success" data-toggle="modal" data-target="#tambah">Tambah Data</button>--}}
    {{-- <a href="/peminjaman/export_excel" class="btn btn-warning my-3" target="_blank">EXPORT EXCEL</a> --}}
     <table id="example" class="table table-bordered js-basic-example dataTable" cellspacing="0">
          <thead>
            <tr>
               <th>Kode Peminjaman</th>
               <th>Nama Peminjam</th>
               {{-- <th>Jumlah</th> --}}
               <th>Dikembalikan Pada</th>
               <th>Status</th>
               <th>Opsi</th>
            </tr>
          </thead>
        </table>
  </div>
</div>


  
  
<script>
 $(document).ready( function () {
    $('#example').DataTable({
           processing: true,
           serverSide: true,
           ajax: "/peminjaman_json",
           columns: [
                    { data: 'kode_peminjaman', name: 'kode_peminjaman' },
                    { data: 'pengguna', name: 'pengguna' },
                    { data: 'tgl_kembali', name: 'tgl_kembali' },
                    { data: 'status', name: 'status' },
                    {data: 'action', name: 'action', orderable: false},
                 ]
        });
     });
</script>
  
@endsection