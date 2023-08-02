@extends('layouts.layout')
@section('content')
<title>Data Mobilitas</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
</div>
 <div class="row"> 
  <div class="col-xl-6 col-md-12 mb-4">
    <div class="card border-left-dark shadow h-100 py-2">
      <div class="card-body">
        <div class="row no-gutters align-items-center">
          <div class="col mr-2">
            <div class="text-xs font-weight-bold text-dark text-uppercase mb-1">Data Mobilitas</div>
            <div class="h5 mb-0 font-weight-bold text-gray-800">{{$log_mobilitas}}</div>
          </div>
          <div class="col-auto">
            <i class="fas fa fa-book fa-2x text-gray-300"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
  
 </div>
 <div class="card shadow mb-4">
<div class="card-header py-3">
  <h6 class="m-0 font-weight-bold text-dark">Data Mobilitas</h6>
</div>

<div class="card-body">
   
  <div class="row">
    <div class="col-6">
    </div>
    <div class="col-2"></div>
    <div class="col-4">
        <div class="row">
          <div class="col-5">
            <input type="text" name="kode_barang" placeholder="Kode Barang" class="form-control float-right" id="search_kode" >
          </div>
          <div class="col-5">
              <input type="text" name="nup" placeholder="NUP" class="form-control float-right" id="search_nup" >
          </div>
          <div class="col-2">
            <button class="btn btn-info" id="search_barang">Search</button>
          </div>
        </div>
    </div>
  </div>
  <br>
  <div class="table-responsive">
      <table id="mobilitas_table" class="table table-bordered js-basic-example dataTable" cellspacing="0">
          <thead>
            <tr>
              <th>No</th>
              <th>User</th>
              <th>Nama Barang</th>
              <th>Kode Barang</th>
              <th>NUP</th>
              <th>Tanggal</th>
              <th class="text-white bg-danger">Sebelum</th>
              <th class="text-white bg-success">Sesudah</th>
          </tr>
        </thead>
    </table>
          
  </div>
</div>

<script>
  $(document).ready( function () {
    fill_table();

    function fill_table(search_kode = '', search_nup = '') {

      var Table = $('#mobilitas_table').DataTable({
        
          dom: 'Bftpl',
          buttons: [
            {
                extend: 'excelHtml5',
                title: 'Data Mobilitas',
                exportOptions: {
                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                }
            },
            {
                extend: 'pdfHtml5',
                title: 'Data Mobilitas',
                exportOptions: {
                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                }
            },
            {
                extend: 'print',
                title: 'Data Mobilitas',
                exportOptions: {
                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                }
            },
        ],
          processing: true,
          serverSide: true,
          searching: false,
          ajax: {
            url: "/mobilitas_json",
            data: {search_kode:search_kode, search_nup:search_nup},
          },
           
           columns: [
                    { data: 'DT_RowIndex', name: 'DT_RowIndex', oderable: false, searchable: false },
                    { data: 'user', name: 'user' },
                    { data: 'nama_barang', name: 'nama_barang' },
                    { data: 'kode_barang', name: 'kode_barang' },
                    { data: 'nup', name: 'nup' },
                    { data: 'tanggal', name: 'tanggal' },
                    { data: 'sebelum', name: 'sebelum' },
                    { data: 'sesudah', name: 'sesudah' },
                 ]
        });
  }
    
    

        $('#search_barang').on( 'click', function () {
                var search_nup = $('#search_nup').val();
                var search_kode = $('#search_kode').val();

                if (search_kode != '' || search_nup != '') {
                  $('#mobilitas_table').DataTable().destroy();
                  fill_table(search_kode, search_nup);
                } else {
                  
                }
                 
        });
     });

</script>
@endsection