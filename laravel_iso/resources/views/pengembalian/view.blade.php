@extends('layouts.layout')
@section('content')
<title>Data Pengembalian</title>
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
            <div class="text-xs font-weight-bold text-dark text-uppercase mb-1">Total Pengembalian</div>
            <div class="h5 mb-0 font-weight-bold text-gray-800">{{$pengembalian}}</div>
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
  <h6 class="m-0 font-weight-bold text-dark">Data Pengembalian</h6>
</div>
<div class="card-body">
  <div class="table-responsive">
    <button class="btn btn-success" data-toggle="modal" data-target="#tambah"><i class="fa fa-plus-square" aria-hidden="true"></i> &nbsp;&nbsp;Pengembalian Barang</button>
    <br><br>
    {{-- <a href="/peminjaman/export_excel" class="btn btn-warning my-3" target="_blank">EXPORT EXCEL</a> --}}
     <table id="example" class="table table-bordered js-basic-example dataTable" cellspacing="0">
          <thead>
            <tr>
               <th>Kode Peminjaman</th>
               <th>Nama Peminjam</th>
               <th>Dikembalikan Pada</th>
               <th>Tanggal Kembali</th>
               {{-- <th>Status</th> --}}
               <th>Opsi</th>
            </tr>
          </thead>
        </table>
  </div>
</div>

<div id="tambah" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Masukan Kode Peminjaman</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
        <form action="{{ url('cek_kode') }}" method="post">
          @csrf
          <div class="form-group">
              <label for="">Kode Peminjaman</label>
              <input type="text" name="kode_peminjaman" class="form-control"  required>
          </div>
          
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <button type="submit" class="btn btn-primary">Simpan</button>
        </form>
        </div>
      </div>
    </div>
  </div>


  
  
<script>
 $(document).ready( function () {
    $('#example').DataTable({
           processing: true,
           serverSide: true,
           ajax: "/pengembalian_json",
           columns: [
                    { data: 'kode_peminjaman', name: 'kode_peminjaman' },
                    { data: 'pengguna', name: 'pengguna' },
                    { data: 'tgl_kembali', name: 'tgl_kembali' },
                    { data: 'tgl_kembali', name: 'tgl_kembali' },
                    {data: 'action', name: 'action', orderable: false},
                 ]
        });
     });
</script>
  
@endsection