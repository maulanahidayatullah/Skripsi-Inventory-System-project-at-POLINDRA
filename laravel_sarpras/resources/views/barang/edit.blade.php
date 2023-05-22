@extends('layouts.layout')
@section('content')
<title>Edit Data Barang</title>
<div class="card-header py-3">
  <h6 class="m-0 font-weight-bold text-dark">Edit Data</h6>
</div>
<div class="card-body">
    <div class="x_content">
      <form action="/barang/update" method="post">
          @csrf
          <input type="hidden" name="id_inventori" value="{{ $inventori->id }}">
          <div class="form-group">
              <label for="">Uraian Akun</label>
              <input type="text" name="uraian_akun" class="form-control" value="{{ $inventori->uraian_akun }}"  required>
          </div>
          <div class="form-group">
              <label for="">Kode Barang</label>
              <input type="text" name="kode_barang" class="form-control" value="{{ $inventori->kode_barang }}"  required>
          </div>
          <div class="form-group">
              <label for="">Nama Barang</label>
              <input type="text" name="nama_barang" class="form-control" value="{{ $inventori->nama_barang }}" required>
          </div>
          <div class="form-group">
              <label for="">Tahun Perolehan</label>
              <input type="text" name="tahun_perolehan" class="form-control" value="{{ $inventori->tahun_perolehan }}"  required>
          </div>
          <div class="form-group">
              <label for="">NUP</label>
              <input type="text" class="form-control" value="{{ $inventori->nup }}" disabled>
              <input type="hidden" name="nup" value="{{ $inventori->nup }}">
          </div>
          <div class="form-group">
              <label for="">Merk/Type</label>
              <input type="text" name="merk_type" class="form-control" value="{{ $inventori->merk_type }}"  required>
          </div>
          <div class="form-group">
              <label for="">Kuantitas</label>
              <input type="number" name="kuantitas" class="form-control" value="{{ $inventori->kuantitas }}"  required>
          </div>
          <div class="form-group">
              <label for="">Nilai BMN</label>
              <input type="number" name="nilai_bmn" class="form-control"  value="{{ $inventori->nilai_bmn }}" required>
          </div>
          <div class="form-group">
            <label for="">Kondisi Barang</label>
            <select class="myselect" name="kondisi_barang" id="" style="width:100%">
              <option></option>
              <option value="B" {{ $inventori->kondisi_barang == 'B' ? 'selected' : '' }}>B</option>
              <option value="RR" {{ $inventori->kondisi_barang == 'RR' ? 'selected' : '' }}>RR</option>
              <option value="RB" {{ $inventori->kondisi_barang == 'RB' ? 'selected' : '' }}>RB</option>
            </select>
          </div>
          <div class="form-group">
              <label for="">Keberadaan Barang</label>
              <select class="form-control myselect" name="keberadaan_barang" name="keberadaan_barang" aria-label="Default select example" style="width:100%">
                <option></option>
                <option value="BD" {{ $inventori->keberadaan_barang == 'BD' ? 'selected' : '' }}>BD</option>
                <option value="BTD" {{ $inventori->keberadaan_barang == 'BTD' ? 'selected' : '' }}>BTD</option>
                <option value="Berlebih" {{ $inventori->keberadaan_barang == 'Berlebih' ? 'selected' : '' }}>Berlebih</option>
              </select>
          </div>
          <div class="form-group">
              <label for="">Pelabelan Kodefikai</label>
              <select class="form-control myselect" name="pelabelan_kodefikasi" aria-label="Default select example" style="width:100%">
                <option></option>
                <option value="sudah" {{ $inventori->pelabelan_kodefikasi == 'sudah' ? 'selected' : '' }}>Sudah</option>
                <option value="belum" {{ $inventori->pelabelan_kodefikasi == 'belum' ? 'selected' : '' }}>Belum</option>
              </select>
          </div>
          <div class="form-group">
            <label for="">Nama Gedung</label>
            <select class="myselect" id="gedung" name="gedung_id" style="width:100%; padding: 100%;" onchange="gentiGedung()">
                <option></option>
                @foreach ($gedung as $item)
                  <option value="{{ $item->id_gedung }}" {{ $inventori->gedung_id == $item->id_gedung ? 'selected' : '' }}>{{ $item->gedung }}</option>
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
                <option value="sudah" {{ $inventori->status_psp == 'sudah' ? 'selected' : '' }}>Sudah</option>
                <option value="belum" {{ $inventori->status_psp == 'belum' ? 'selected' : '' }}>Belum</option>
              </select>
          </div>
          <div class="form-group">
              <label for="">Nama Sub Satker</label>
              <input type="text" name="nama_sub_satker" class="form-control" value="{{ $inventori->nama_sub_satker }}"  required>
          </div>
          <div class="form-group">
              <label for="">Keterangan</label>
              <input type="text" name="keterangan" class="form-control" value="{{ $inventori->keterangan }}"  required>
          </div>
          
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <button type="submit" class="btn btn-primary">Simpan</button>
        </form>
    </div>
@endsection