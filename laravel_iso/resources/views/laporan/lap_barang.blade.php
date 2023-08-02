@extends('layouts.layout')
@section('content')
<title>Laporan Data Barang</title>
</div>
<div class="card shadow mb-4">
    <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-dark">Laporan Data Barang</h6>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="">Filter Berdasarkan</label>
                    <select class="myselect" name="" id="filter" style="width:100%" required>
                            <option></option>
                        <option value="tahun">Tahun</option>
                        <option value="gedung_ruangan">Gedung & Ruangan</option>
                    </select>
                </div>
            </div>
        </div>
        {{-- <form action="lap_barang_keluar_input" method="post">
            @csrf --}}
            <div class="form" id="form_tahun" style="display: none">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="">Tanggal Awal</label>
                            <input type="date" name="awal" required class="form-control">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="">Tanggal Akhir</label>
                            <input type="date" name="akhir" required class="form-control">
                        </div>
                    </div>
                </div>
                <center><input type="submit" class="btn btn-success"></center>
            </div>

            <div class="form" id="form_gedung_ruangan" style="display: none">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="">Nama Gedung</label>
                            <select class="myselect" id="gedung_id" name="gedung_id" style="width:100%; padding: 100%;" onchange="gentiGedung()">
                                <option></option>
                                @foreach ($gedung as $item)
                                    <option value="{{ $item->id_gedung }}">{{ $item->gedung }}</option>
                                @endforeach
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group" id="ruangan_select">

                        </div>
                    </div>
                </div>
                <center><input type="submit" id="btn_submit" class="btn btn-success"></center>
            </div>
            
      {{-- </form> --}}
<br>
    </div>
</div>
<div class="card shadow mb-4">
<div class="card-header py-3">
  <h6 class="m-0 font-weight-bold text-dark">Laporan Data Barang</h6>
</div>
<div class="card-body" id="card-table" style="display: none">
  <div class="table-responsive">
      <table id="example" class="table table-bordered js-basic-example dataTable" cellspacing="0">
          <thead>
            <tr>
              <th>No.</th>
              <th>Uraian Akun</th>
              <th>Kode Barang</th>
              <th>Nama Barang</th>
              <th>Tahun Perolehan</th>
              <th>NUP</th>
              <th>Merk/Type</th>
              <th>Kuantitas</th>
              <th>Nilai BMN</th>
              <th>Kondisi Barang</th>
              <th>Keberadaan Barang</th>
              <th>Pelabelan Kodefikasi</th>
              <th>Pegawai Pengguna Barang</th>
              <th>Nama Gedung</th>
              <th>Nama Ruangan</th>
              <th>Status PSP</th>
              <th>Keterangan</th>
          </tr>
        </thead>
    </table>
          
  </div>
</div>
  
@endsection

@section('script')
    <script>
        function gentiGedung() {
      var id_gedung = document.getElementById("gedung_id").value;
      var url = "{{ url('gedung/ruangan')}}";
      var request = $.ajax({
                    url: url,
                    dataType: "json",
                    type: "POST",
                    data: {
                        _token: '{{ csrf_token() }}',
                        _method: 'POST',
                        id: id_gedung
                    },
                });
                request.done(function(response) {
                    select = '<label for="">Nama Ruangan</label> \
                      <select name="ruangan_id" id="ruangan_id" class="myselect" style="width:100%">\
                        <option></option>'
                      $.each(response, function(i,data)
                      {
                          select +='<option value="'+data.id_ruangan+'">'+data.ruangan+'</option>';
                      });
                    select += '</select>';
                    $("#ruangan_select").html(select);
                    
                    $('.myselect').select2({
                      placeholder: "--- Silahkan Pilih ---"
                    });
                });

                request.fail(function(jqXHR, textStatus) {
                    console.log(jqXHR);
                    Swal.fire('Data failed Approved!', '', 'error')
                });

      
    }

        $(document).ready( function () {
            fill_table();

  function fill_table(filter = '', value_1 = '', value_2 = '') {
    var Table = $('#example').DataTable({
      dom: 'Bftpl',
          buttons: [
            {
                extend: 'excelHtml5',
                title: 'Data Barang',
                exportOptions: {
                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 ]
                }
            },
            {
                extend: 'pdfHtml5',
                title: 'Data Barang',
                exportOptions: {
                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 ]
                }
            },
            {
                extend: 'print',
                title: 'Data Barang',
                exportOptions: {
                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 ]
                }
            },
        ],
           processing: true,
           serverSide: true,
           searching: false,
           ajax: {
            url: "/lap_barang_json",
            data: {filter:filter, value_1:value_1, value_2:value_2},
           },
           
           columns: [
                    { data: 'DT_RowIndex', name: 'DT_RowIndex', oderable: false, searchable: false },
                    { data: 'uraian_akun', name: 'uraian_akun' },
                    { data: 'kode_barang', name: 'kode_barang' },
                    { data: 'nama_barang', name: 'nama_barang' },
                    { data: 'tahun_perolehan', name: 'tahun_perolehan' },
                    { data: 'nup', name: 'nup' },
                    { data: 'merk_type', name: 'merk_type' },
                    { data: 'kuantitas', name: 'kuantitas' },
                    { data: 'nilai_bmn', name: 'nilai_bmn' },
                    { data: 'kondisi_barang', name: 'kondisi_barang' },
                    { data: 'keberadaan_barang', name: 'keberadaan_barang' },
                    { data: 'pelabelan_kodefikasi', name: 'nampelabelan_kodefikasia_barang' },
                    { data: 'pengguna', name: 'pengguna' },
                    { data: 'gedung', name: 'gedung'},
                    { data: 'ruangan', name: 'ruangan' },
                    { data: 'status_psp', name: 'status_psp' },
                    { data: 'keterangan', name: 'keterangan' },
                 ]
        });
  }
            $('#filter').on( 'change', function () {
                var filter = $('#filter').val();

                if (filter == 'tahun') {
                    $('#form_gedung_ruangan').css('display', 'none');
                    $('#form_tahun').css('display', 'block');                   
                } else if (filter == 'gedung_ruangan'){
                    $('#form_tahun').css('display', 'none');   
                    $('#form_gedung_ruangan').css('display', 'block');

                    $('#btn_submit').on( 'click', function () {
                    $('#card-table').css('display', 'block');
                        var gedung_id = $('#gedung_id').val();
                        var ruangan_id = $('#ruangan_id').val();

                        $('#example').DataTable().destroy();
                        fill_table(filter, gedung_id, ruangan_id);
                    });
                }
            });
        });
    </script>
@endsection