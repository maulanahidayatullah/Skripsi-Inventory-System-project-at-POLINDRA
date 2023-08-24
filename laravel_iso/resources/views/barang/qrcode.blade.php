@extends('layouts.layout')
@section('content')
<title>Data Barang</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>  
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
<div class="card-header py-3">
  <center>
    <h5 class="m-0 font-weight-bold text-dark">Pelabelan Barang</h5><br>
    <div type="button"class="btn btn-primary btn-lg" onclick="printDiv(example);"> <i class="fa fa-qrcode "></i> &nbsp; Print QR </div>
  </center>
</div>
<style>
  table, tr, td {
  border: 1px solid black;
  border-collapse: collapse;
}
</style>
<div class="card-body">
  <div id="example">
    <div class="row">
    @foreach ($pelabelan as $value)
      <div class="col-4" style="border: 1px solid;">
        <div class="row">
          <div class="col-2 d-flex align-items-center justify-content-center" style="border: 1px solid"><img src="{{ asset('assets/img/logo.png') }}" style="width:30px;height:30px;"></div>
          <div class="col-6" style="padding: 0; ">
            <div class="col-12" style="border: 1px solid; font-size: 11px;">{{$value->Inventori->kode_barang}}</div>
            <div class="col-12" style="border: 1px solid; font-size: 11px;">
              @php
                  echo substr($value->Inventori->nama_barang,0,22);
              @endphp
            </div>
            <div class="col-12" style="border: 1px solid; font-size: 11px;">
              @php
                  echo substr($value->Inventori->merk_type,0,24);
              @endphp
            </div>
          </div>
          <div class="col-2" style="padding: 0">
            <div class="col-12" style="border: 1px solid; font-size: 11px;">{{$value->Inventori->kuantitas}}</div>
            <div class="col-12" style="border: 1px solid; font-size: 11px;">
              @php
                  echo date("Y", strtotime($value->Inventori->tahun_perolehan));
              @endphp
              {{-- {{$value->Inventori->tahun_perolehan}} --}}
            </div>
            <div class="col-12" style="border: 1px solid; font-size: 11px;">&nbsp;</div>
          </div>
          <div class="col-2 d-flex align-items-center justify-content-center" style="border: 1px solid">{!! QrCode::size(40)->generate($value->Inventori->nup); !!}</div>
        </div>
      </div>
      {{-- <div class="col-4 bg-success">asd</div>
      <div class="col-4 bg-danger">asd </div> --}}
        
      
    @endforeach
    </div>
    <br>
  </div>
        
    
   
                        
</div>

<script>
function printDiv(example) {
   var printContents = document.getElementById("example").innerHTML;    
   var originalContents = document.body.innerHTML;      
   document.body.innerHTML = printContents;     
   window.print();     
   document.body.innerHTML = originalContents;
}
</script>

@endsection