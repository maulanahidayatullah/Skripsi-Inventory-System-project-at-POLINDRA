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
<div class="card-body text-center">
  <div id="example">
    @foreach ($pelabelan as $value)
      <h5>QR Code <br> {{$value->Inventori->nama_barang}}</h5>
        
      {!! QrCode::size(100)->generate($value->Inventori->nup); !!}
    @endforeach
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