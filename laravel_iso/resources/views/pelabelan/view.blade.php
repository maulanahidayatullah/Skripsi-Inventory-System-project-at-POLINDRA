@extends('layouts.layout')
@section('content')
<title>Data Barang</title>
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
            <div class="text-xs font-weight-bold text-dark text-uppercase mb-1">Pelabelan Barang</div>
            <div class="h5 mb-0 font-weight-bold text-gray-800"></div>
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
  <h6 class="m-0 font-weight-bold text-dark">Keranjang Pelabelan Barang</h6>
</div>

<div class="card-body" id="card-table" >
   
  <center><a href="/print_qr"><div class="btn btn-info btn-lg">
            <i class="fa fa-qrcode "></i> &nbsp; Print QR</div></a></center>
  <br>
  <div class="table-responsive">
      <table id="example" class="table table-bordered js-basic-example dataTable" cellspacing="0">
          <thead>
            <tr>
              <th>No</th>
              <th>Nama Barang</th>
              <th>Kode Barang</th>
              <th>NUP</th>
              <th>Tahun Perolehan</th>
              <th>Opsi</th>
          </tr>
        </thead>
    </table>
          
  </div>
</div>

<script>
  

  function hapus(pelabelan_id){
      var url = "{{ url('hapus_pelabelan')}}";
      var request = $.ajax({
                    url: url,
                    dataType: "json",
                    type: "POST",
                    data: {
                        _token: '{{ csrf_token() }}',
                        _method: 'POST',
                        pelabelan_id: pelabelan_id
                    },
                });

          request.done(function(res) {
            // console.log(res);
              swal(
                'Data Berhasil Dihapus',
                '',
                'success'
              )
              $('#example').DataTable().clear().draw();
              // Table.ajax.reload();
              // fill_table();
          });

          request.fail(function(jqXHR, textStatus) {
              console.log(jqXHR);
          });
    }
  $(document).ready( function () {

    var Table = $('#example').DataTable({
        dom: 'tpl',
        processing: true,
        serverSide: true,
        searching: false,
        ajax: {
          url: "/pelabelan_json",
        },
           
           columns: [
                    { data: 'DT_RowIndex', name: 'DT_RowIndex', oderable: false, searchable: false },
                    { data: 'nama_barang', name: 'nama_barang' },
                    { data: 'kode_barang', name: 'kode_barang' },
                    { data: 'nup', name: 'nup' },
                    { data: 'tahun', name: 'tahun' },
                    { data: 'action', name: 'action', orderable: false},
                 ]
        });
    

      $('#user_select').on( 'change', function () {
        var user_id = $('#user_select').val();
        $('#card-table').css("display","block")
            $('#mobilitas_table').DataTable().destroy();
            fill_table(user_id);
                    
          });
    
        $('#search_barang').on( 'click', function () {
          var search_nup = $('#search_nup').val();
          var search_kode = $('#search_kode').val();
          var user_id = $('#user_select').val();

          if (search_kode != '' || search_nup != '') {
            $('#mobilitas_table').DataTable().destroy();
              fill_table(user_id, search_kode, search_nup);
            } else {
                  
            }
                 
        });
    
     });

</script>
@endsection