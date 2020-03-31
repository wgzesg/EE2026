//
// Vivado(TM)
// rundef.js: a Vivado-generated Runs Script for WSH 5.1/5.6
// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//

<<<<<<< HEAD
=======
echo "This script was generated under a different operating system."
echo "Please update the PATH variable below, before executing this script"
exit

>>>>>>> 2df6aee9930837762d1bca2ec291f2320556f75e
var WshShell = new ActiveXObject( "WScript.Shell" );
var ProcEnv = WshShell.Environment( "Process" );
var PathVal = ProcEnv("PATH");
if ( PathVal.length == 0 ) {
<<<<<<< HEAD
  PathVal = "C:/Xilinx/SDK/2018.2/bin;C:/Xilinx/Vivado/2018.2/ids_lite/ISE/bin/nt64;C:/Xilinx/Vivado/2018.2/ids_lite/ISE/lib/nt64;C:/Xilinx/Vivado/2018.2/bin;";
} else {
  PathVal = "C:/Xilinx/SDK/2018.2/bin;C:/Xilinx/Vivado/2018.2/ids_lite/ISE/bin/nt64;C:/Xilinx/Vivado/2018.2/ids_lite/ISE/lib/nt64;C:/Xilinx/Vivado/2018.2/bin;" + PathVal;
=======
  PathVal = "/home/wgzesg/SDK/2018.2/bin:/home/wgzesg/Vivado/2018.2/ids_lite/ISE/bin/lin64;/home/wgzesg/Vivado/2018.2/ids_lite/ISE/lib/lin64;/home/wgzesg/Vivado/2018.2/bin;";
} else {
  PathVal = "/home/wgzesg/SDK/2018.2/bin:/home/wgzesg/Vivado/2018.2/ids_lite/ISE/bin/lin64;/home/wgzesg/Vivado/2018.2/ids_lite/ISE/lib/lin64;/home/wgzesg/Vivado/2018.2/bin;" + PathVal;
>>>>>>> 2df6aee9930837762d1bca2ec291f2320556f75e
}

ProcEnv("PATH") = PathVal;

var RDScrFP = WScript.ScriptFullName;
var RDScrN = WScript.ScriptName;
var RDScrDir = RDScrFP.substr( 0, RDScrFP.length - RDScrN.length - 1 );
var ISEJScriptLib = RDScrDir + "/ISEWrap.js";
eval( EAInclude(ISEJScriptLib) );


ISEStep( "vivado",
         "-log Top_Student.vds -m64 -product Vivado -mode batch -messageDb vivado.pb -notrace -source Top_Student.tcl" );



function EAInclude( EAInclFilename ) {
  var EAFso = new ActiveXObject( "Scripting.FileSystemObject" );
  var EAInclFile = EAFso.OpenTextFile( EAInclFilename );
  var EAIFContents = EAInclFile.ReadAll();
  EAInclFile.Close();
  return EAIFContents;
}
