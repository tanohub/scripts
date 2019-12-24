<#
.SYNOPSIS
Sends a ping to a specified host. Colors the output to indicate latency.
.DESCRIPTION
Version 1.1. Provides a simple network monitoring solution, without the need to install any software.
.EXAMPLE
MultiPing ServerX 2
Sends a ping to ServerX every second. Repeats forever.
.EXAMPLE
MultiPing ServerX, ServerY, 10.1.1.254, www.google.com
Sends a ping to two servers, the IP address of the default gateway and a webserver on the internet
#>

param($computername="localhost", [bool]$repeat=$false, [int]$PingCritical=15, [int]$PingWarning=12)

Write-Host "Pinging $($computername.count) remote systems, repeat is $repeat. Interrupt with Ctrl-C." -Foregroundcolor green
Write-Host "Thresholds: critical=$PingCritical, warning=$PingWarning" -Foregroundcolor green
Do {
  $computername | foreach {
    $a = Test-Connection $_ -Count 1 -ErrorAction SilentlyContinue
    if (!$?) { Write-Host "$_ DOWN! " -nonewline -fore red }
    else {
      $msg = "$($a.Address) $($a.ResponseTime.ToString().PadRight(4))"
      if     ($a.ResponseTime -ge $PingCritical) { write-host $msg -nonewline -fore red }
      elseif ($a.ResponseTime -ge $PingWarning)  { write-host $msg -nonewline -fore yellow }
      else                                       { write-host $msg -nonewline }
    }
  }
Write-Host ""
Start-Sleep (1)
} while ($repeat)
