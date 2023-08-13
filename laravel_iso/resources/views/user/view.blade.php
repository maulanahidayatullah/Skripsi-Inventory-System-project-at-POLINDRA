@extends('layouts.layout') @section('content')
<title>Data Admin</title>
<div class="card-header py-3">
    <h6 class="m-0 font-weight-bold text-dark">Data User</h6>
</div>
<div class="card-body">
    <div class="table-responsive">
        <div>
             @error('email')
                            <span class="help-block">
                                <strong style="color:red">{{ $message }}</strong>
                            </span>
            @enderror
            <br>
             @error('username')
                            <span class="help-block">
                                <strong style="color:red">{{ $message }}</strong>
                            </span>
                       
            @enderror
        </div>
         
        <button class="btn btn-success" data-toggle="modal" data-target="#tambah">Tambah Data</button>
        <br>
        <br>
        <table id="dataTable" class="table table-bordered" cellspacing="0">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Nama</th>
                    <th>Email</th>
                    <th>Username</th>
                    <th>Password</th>
                    <th>Level / Jabatan</th>
                    <th>Alamat</th>
                    <th>No Hp</th>
                    <th>Opsi</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($user as $i => $u)
                <tr class="data-row">
                    <td class="align-middle iteration">{{ ++$i }}</td>
                    <td class="align-middle name">{{ $u->name }}</td>
                     <td class="align-middle name">{{ $u->email }}</td>
                    <td class="align-middle username">{{ $u->username }}</td>
                    <td class="align-middle password">Password Tidak Ditampilkan</td>
                    <td class="align-middle level">
                        @if ($u->level == 'user_1')
                            Admin 1
                        @elseif($u->level == 'user_2')
                            Admin 2
                        @elseif($u->level == 'user_3')
                            Pegawai / Mahasiswa
                        @elseif($u->level == 'user_4')
                            Pembimbing Organisasi / Penanggung Jawab Instansi
                        @else
                            Wakil Direktur 2
                        @endif
                    </td>
                    <td class="align-middle level">{{ $u->alamat }}</td>
                    <td class="align-middle level">{{ $u->no_hp }}</td>
                   
                    <td>
                        <div class="row">
                                <a href="/user/edit/{{ $u->id }}" class="btn btn-primary btn-sm ml-2">Edit</a>
                            {{-- <form action="{{ route('user.destroy',$u->id) }}" method="POST">
                                @csrf @method('DELETE')
                                <button type="submit" class="btn btn-danger btn-sm ml-2">Delete</button>
                            </form> --}}
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
                <form action="{{ route('user.store') }}" method="post">
                    @csrf
                    <div class="form-group">
                        <label for="">Nama</label>
                        <input type="text" name="name" class="form-control" required placeholder="Masukan Nama">
                    </div>
                    <div class="form-group">
                        <label for="">Email</label>
                        <input type="email" name="email" class="form-control" required placeholder="Masukan mail">
                    </div>
                    <div class="form-group">
                        <label for="">Username</label>
                        <input type="text" name="username" class="form-control" required placeholder="Masukan Username">
                      
                    </div>
                    <div class="form-group">
                        <label for="">Password</label>
                        <input type="password" name="password" class="form-control" required placeholder="Masukan Password">
                    </div>
                    <div class="form-group">
                        <label for="">No HP</label>
                        <input type="text" name="no_hp" class="form-control" required placeholder="Masukan No HP">
                    </div>
                    <div class="form-group">
                        <label for="">Alamat</label>
                        <input type="text" name="alamat" class="form-control" required placeholder="Masukan Alamat">
                    </div>
                    {{-- <input type="hidden" name="level" value="admin"> --}}
                    <div class="form-group">
                        <label for="">Level / Jabatan User</label>
                        <select class="myselect" name="level" id="" style="width:100%">
                            <option></option>
                            <option value="user_1">Admin 1</option>
                            <option value="user_2">Admin 2</option>
                            <option value="user_3">Pegawai / Mahasiswa</option>
                            <option value="user_4">Pembimbing Organisasi / Penanggung Jawab Instansi</option>
                            <option value="user_5">Wakil Direktur 2</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="">Instansi / Organisasi</label>
                        <select class="myselect" name="instansi_id" id="" style="width:100%">
                            <option></option>
                            @foreach ($instansi as $value)
                                <option value="{{ $value->id }}">{{ $value->nama }}</option>
                            @endforeach
                        </select>
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