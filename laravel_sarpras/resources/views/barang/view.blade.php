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
            <div class="text-xs font-weight-bold text-dark text-uppercase mb-1">Barang</div>
            <div class="h5 mb-0 font-weight-bold text-gray-800">{{$barang}}</div>
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
  <h6 class="m-0 font-weight-bold text-dark">Data Barang</h6>
</div>

<div class="card-body">
   
  <div class="table-responsive">
    <button class="btn btn-success" data-toggle="modal" data-target="#tambah">Tambah Data</button>
      <br>
      <br>
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
              <th>Nama Sub Satker</th>
              <th>Keterangan</th>
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
          <h4 class="modal-title">Masukan Data</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
        <form action="{{ route('barang.store') }}" method="post">
          @csrf
          <div class="form-group">
              <label for="">Uraian Akun</label>
              <input type="text" name="uraian_akun" class="form-control"  required>
          </div>
          <div class="form-group">
              <label for="">Kode Barang</label>
              <input type="text" name="kode_barang" class="form-control"  required>
          </div>
          <div class="form-group">
              <label for="">Nama Barang</label>
              <input type="text" name="nama_barang" class="form-control"  required>
          </div>
          <div class="form-group">
              <label for="">Tahun Perolehan</label>
              <input type="text" name="tahun_perolehan" class="form-control"  required>
          </div>
          <div class="form-group">
              <label for="">NUP</label>
              <input type="text" name="nup" class="form-control" required>
          </div>
          <div class="form-group">
              <label for="">Merk/Type</label>
              <input type="text" name="merk_type" class="form-control"  required>
          </div>
          <div class="form-group">
              <label for="">Kuantitas</label>
              <input type="number" name="kuantitas" class="form-control"  required>
          </div>
          <div class="form-group">
              <label for="">Nilai BMN</label>
              <input type="number" name="nilai_bmn" class="form-control"  required>
          </div>
          <div class="form-group">
            <label for="">Kondisi Barang</label>
            <select class="myselect" name="kondisi_barang" id="" style="width:100%">
                <option></option>
              <option value="B">B</option>
              <option value="RR">RR</option>
              <option value="RB">RB</option>
            </select>
          </div>
          <div class="form-group">
              <label for="">Keberadaan Barang</label>
              <select class="form-control myselect" name="keberadaan_barang" name="keberadaan_barang" aria-label="Default select example" style="width:100%">
                <option></option>
                <option value="BD">BD</option>
                <option value="BTD">BTD</option>
                <option value="Berlebih">Berlebih</option>
              </select>
          </div>
          <div class="form-group">
              <label for="">Pelabelan Kodefikai</label>
              <select class="form-control myselect" name="pelabelan_kodefikasi" aria-label="Default select example" style="width:100%">
                <option></option>
                <option value="sudah">Sudah</option>
                <option value="belum">Belum</option>
              </select>
          </div>
          <div class="form-group">
            <label for="">Nama Gedung</label>
            <select class="myselect" id="gedung" name="gedung_id" style="width:100%; padding: 100%;" onchange="gentiGedung()">
                <option></option>
                @foreach ($gedung as $item)
                  <option value="{{ $item->id_gedung }}">{{ $item->gedung }}</option>
                @endforeach
            </select>
          </div>
          <div class="form-group">
            <div id="ruangan_select">

            </div>
          </div>
          <div class="form-group">
              <label for="">Status PSP</label>
              <select class="form-control myselect" name="status_psp" aria-label="Default select example" style="width:100%">
                <option></option>
                <option value="Sudah">Sudah</option>
                <option value="Belum">Belum</option>
              </select>
          </div>
          <div class="form-group">
              <label for="">Nama Sub Satker</label>
              <input type="text" name="nama_sub_satker" class="form-control"  required>
          </div>
          <div class="form-group">
              <label for="">Keterangan</label>
              <input type="text" name="keterangan" class="form-control"  required>
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
    function gentiGedung() {
      var id_gedung = document.getElementById("gedung").value;
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
                      <select name="ruangan_id" class="myselect" style="width:100%">\
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
    // $(document).on('click','#gedung',function(){
    //your code
      // console.log('asd');
    // })
    // $('#gedung').change(function() {
    //   // alert($(this).val()); 
    //   console.log('asd');
    // });
 $(document).ready( function () {
    
    $('#example').DataTable({
           processing: true,
           serverSide: true,
           ajax: "/barang_json",
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
                    { data: 'pegawai_id', name: 'pegawai_id' },
                    { data: 'gedung', name: 'gedung'},
                    { data: 'ruangan', name: 'ruangan' },
                    { data: 'status_psp', name: 'status_psp' },
                    { data: 'nama_sub_satker', name: 'nama_sub_satker' },
                    { data: 'keterangan', name: 'keterangan' },
                    { data: 'action', name: 'action', orderable: false},
                 ]
        });
     });

</script>
@endsection