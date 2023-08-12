@extends('layouts.layout')
@section('content')
<title>Data Instansi</title>

<div class="card-header py-3">
  <h6 class="m-0 font-weight-bold text-dark">Data Instansi</h6>
</div>
<div class="card-body">
  <div class="table-responsive">
    <button class="btn btn-success" data-toggle="modal" data-target="#tambah">Tambah Data</button>
      <br>
      <br>
      <table id="dataTable" class="table table-bordered" cellspacing="0">
          <thead>
            <tr>
                  <th>No</th>
                  <th>Nama Instansi</th>
                  <th>Opsi</th>
            </tr>
          </thead>
          <tbody>
            @foreach ($instansi as $i => $value)
            <tr class="data-row">
              <td class="align-middle iteration">{{ ++$i }}</td>
              <td class="align-middle id_barang">{{ $value->nama }}</td>
              <td>  
                <div class="row">
                   <a href="/instansi/edit/{{ $value->id}}" class="btn btn-primary btn-sm ml-2">Edit</a>
                   <a href="/instansi/delete/{{ $value->id }}" class="btn btn-danger btn-sm ml-2">Hapus</a>
                </div>
              </td>
            </tr>
            @endforeach
          </tbody>
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
        <form action="/instansi/store" method="post">
            {{ csrf_field() }}
          <div class="form-group">
              <label for="">Nama Instansi</label>
              <input type="text" name="instansi" class="form-control"  required>
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
@endsection