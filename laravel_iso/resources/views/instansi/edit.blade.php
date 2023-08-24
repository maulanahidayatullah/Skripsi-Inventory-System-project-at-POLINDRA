@extends('layouts.layout')
@section('content')
<title>Edit Data Instansi</title>
<div class="card-header py-3">
  <h6 class="m-0 font-weight-bold text-dark">Edit Data Instansi</h6>
</div>
<div class="card-body">
    <div class="x_content">
            <form action="/instansi/update" method="post">
                    {{ csrf_field() }}
                  <div class="form-group">
                    <label for="">Nama Instansi</label>
                    <input type="text" name="instansi" class="form-control" value="{{$instansi->nama}}" required placeholder="Masukan ruangan">
                    <input type="hidden" name="id_instansi" class="form-control" value="{{$instansi->id}}" required>
                  </div>
          </div>
                </div>
                
          </div>
                  <button type="submit" class="btn btn-primary">Update</button>
            </form>
    </div>
@endsection