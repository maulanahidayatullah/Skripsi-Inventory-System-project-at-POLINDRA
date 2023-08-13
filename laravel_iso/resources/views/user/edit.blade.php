@extends('layouts.layout')
@section('content')
<title>Edit Data Users</title>
<div class="card-header py-3">
  <h6 class="m-0 font-weight-bold text-dark">Edit Data</h6>
</div>
<div class="card-body">
    <div class="x_content">
            <form action="/user/update" method="post">
                    @csrf
                  <div class="form-group">
                      <label for="">Nama</label>
                      <input type="hidden" name="id" class="form-control" value="{{$user->id}}" required placeholder="Masukan Nama">
                      <input type="text" name="name" class="form-control" value="{{$user->name}}" required placeholder="Masukan Nama">
                  </div>
                  <div class="form-group">
                        <label for="">Username</label>
                        <input type="text" name="username" class="form-control" value="{{$user->username}}" required placeholder="Masukan Username">
                        {{-- @error('username')
                                <span class="help-block">
                                    <strong style="color:red">{{ $message }}</strong>
                                </span>
                        @enderror --}}
                    </div>
                   <div class="form-group">
                        <label for="">Email</label>
                        <input type="email" name="email" class="form-control" value="{{$user->email}}" required placeholder="Masukan email">
                        {{-- @error('email')
                            <span class="help-block">
                                <strong style="color:red">{{ $message }}</strong>
                            </span>
                        @enderror --}}
                    </div>
                    <div class="form-group">
                        <label for="">Alamat</label>
                        <input type="text" name="alamat" class="form-control" value="{{$user->alamat}}" required placeholder="Masukan Alamat">
                    </div>

                    <div class="form-group">
                        <label for="">No HP</label>
                        <input type="number" name="no_hp" class="form-control" value="{{$user->no_hp}}" required placeholder="Masukan No HP">
                    </div>
                    
                    <div class="form-group">
                        <label for="">Level / Jabatan User</label>
                        <select class="myselect" name="level" id="" style="width:100%">
                            <option></option>
                            <option value="user_1" {{ $user->level === 'user_1' ? 'selected' : '' }}>Admin 1</option>
                            <option value="user_2" {{ $user->level === 'user_2' ? 'selected' : '' }}>Admin 2</option>
                            <option value="user_3" {{ $user->level === 'user_3' ? 'selected' : '' }}>Pegawai / Mahasiswa</option>
                            <option value="user_4" {{ $user->level === 'user_4' ? 'selected' : '' }}>Pembimbing Organisasi / Penanggung Jawab Instansi</option>
                            <option value="user_5" {{ $user->level === 'user_5' ? 'selected' : '' }}>Wakil Direktur 2</option>
                        </select>
                    </div>


                    <div class="form-group">
                        <label for="">Instansi / Organisasi</label>
                        <select class="myselect" name="instansi_id" style="width:100%; padding: 100%;">
                            <option></option>
                            @foreach ($instansi as $item)
                            <option value="{{ $item->id }}" {{ $user->instansi_id == $item->id ? 'selected' : '' }}>{{ $item->nama }}</option>
                            @endforeach
                        </select>
                    </div>

                    <div class="form-group">
                      <label for="">Password Baru (Kosongkan bila tidak perlu)</label>
                      <input type="password" name="new_password" class="form-control" value="" placeholder="Masukan Password Baru">
                    </div>
                
                    <button type="submit" class="btn btn-primary">Simpan</button>
                </div> 
            </form>
    </div>
@endsection