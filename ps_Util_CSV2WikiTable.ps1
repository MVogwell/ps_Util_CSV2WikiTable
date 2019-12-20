# Convert csv to wiki-table
# MVogwell - 30-05-17


Param(
	[Parameter(Mandatory=$True)][string]$CSVFilePath="",
	[Parameter(Mandatory=$True)][string]$OutputFilePath=""
)

[CmdletBinding()]
$ErrorActionPreference = "Stop"

write-host ""
write-host ""


if($CSVFilePath.length -lt 3) {
	write-host "Path not specified - exiting!" -fore red
}
else {
	if((Test-Path $CSVFilePath) -and ($OutputFilePath.length -gt 5)) {
		$fCSVData = get-content $CSVFilePath
		$Counter = 1
		
		try {
			New-Item $OutputFilePath -Type File -force | out-null
		}
		catch {
			write-host "Unable to create file $OutputFilePath"
			write-host "The script will now close"
			Exit
		}
		finally {}
		
		# CHANGE ADD-CONTENT TO FILE STREAM WRITER
		
		$stream = [System.IO.StreamWriter] $OutputFilePath 
		
		$stream.writeline($("{| class='wikitable'"))
		
		foreach ($d in $fCSVData) {
			$tmp = $d.split(",")
			if($Counter -eq 1) {	#First row is set as the header row
				foreach($l in $tmp) {
					if(($l.length -eq 1) -and ($l -eq "-")) {
						$l = "~"
					}
					elseif(($l.length -gt 1) -and ($l.substring(0,1) -eq "-")) {
						$l = "~" + $a.Substring(1,$a.length-1)
					}
					$stream.writeline($("!" + $l))
				}
				$Counter = 2
			}
			else {
				foreach($l in $tmp) {
					if(($l.length -eq 1) -and ($l -eq "-")) {
						$l = "~"
					}
					elseif(($l.length -gt 1) -and ($l.substring(0,1) -eq "-")) {
						$l = "~" + $a.Substring(1,$a.length-1)
					}
					$stream.writeline($("|" + $l))
				}			
			}
			
			# Add the row delimiter
			$stream.writeline("|-")
		}
	
		$stream.writeline($("|}"))

		write-host ""
		write-host ""
		write-host "That's all folks!"
		
		. notepad.exe $OutputFilePath
		
	}
	else {
		write-host "Nope... that file doesn't exist!" -fore red
	}
}

$stream.close()


write-host ""
write-host ""

# SIG # Begin signature block
# MIIPBgYJKoZIhvcNAQcCoIIO9zCCDvMCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUQkshA25B3CYTOtQtELfMObgv
# tI6gggyhMIIGMzCCBBugAwIBAgICEAIwDQYJKoZIhvcNAQELBQAwgcIxCzAJBgNV
# BAYTAkdCMRgwFgYDVQQIDA9HbG91Y2VzdGVyc2hpcmUxEzARBgNVBAcMCkNoZWx0
# ZW5oYW0xGjAYBgNVBAoMEVVsdHJhIEVsZWN0cm9uaWNzMSUwIwYDVQQLDBxQcmVj
# aXNpb24gQWlyICYgTGFuZCBTeXN0ZW1zMRcwFQYDVQQDDA5VRVBBTFMgUm9vdCBD
# QTEoMCYGCSqGSIb3DQEJARYZcG9zdG1hc3RlckB1bHRyYS1wYWxzLmNvbTAeFw0x
# NjEyMDkxMTA0MjFaFw0yNjEyMDcxMTA0MjFaMBcxFTATBgNVBAMTDHVlcGFscy1z
# dWJjYTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAJqHNDWz19b3boAY
# I6fg+ckQdy6gkO+/5O3IELAoQBsDbMQyEgDVpL/S+7d17YdhgPU6gZ9+XIsREScf
# D2ZKXhEfuPgF/MQKehKX3U+3WcbLqDXAH4XQxpDlwE9TIa4KBKOJy/26aR85AOpi
# 9K65x3tY3g6cAGqxu+GVMkPcWzczO8WmdLnFPQte2LGTVKa5W1oLPAGy6q03LLFj
# SaIDLFgjXBlsmoFazFUQdpfqbcHanx86/fdh8pFnOd1xMc2TgpNeLkwVkJv5lMgC
# kRkWWKD/EwxQGTKUM+FUkWSLRWNO/xih5Ao8vbeUjsP/XNbFQSrQA3cgkva7VE2Z
# ZKOjCRHzrr4qbYm9gEOG/1Q6YeKMroNbKRjZItJnfsFeQ/hiejG5wZTEbughJkO6
# AKk0mcNlRhqvH3sLQsOS0KPDUWbHiHvtqEyM1WQMOTkJ9hyPzVSmouMEn/1ccqDG
# KsETQkGkjZvJFSWYwOUYgcPyRI6aCIo2m41OOoG64oJngJe4BbyYbT5D6XQqWwbe
# aFP6j8ZYJUoOdcZVpH3PC+rzfCyEPSQAcQ9YLlPihrAMCBRg3xHokG/g5RZbMWuI
# /knannYuDhHk3c/8xmdX1suVyJDsXRMKhRdHWBdD5eOYD3CTJqnWYFfcMo6uyUTH
# yyMDfSdbpprY9DmnAA7LOwH+kdUnAgMBAAGjgdwwgdkwHQYDVR0OBBYEFMuTvwev
# EDx4zd4gXSsEvzgejembMB8GA1UdIwQYMBaAFKNyjxR1xvhIhmiVgzis7rO70yxq
# MBIGA1UdEwEB/wQIMAYBAf8CAQAwDgYDVR0PAQH/BAQDAgGGMD4GCCsGAQUFBwEB
# BDIwMDAuBggrBgEFBQcwAoYiaHR0cDovL3Jvb3QtY2EudWVwYWxzLmNvbS9yb290
# LnBlbTAzBgNVHR8ELDAqMCigJqAkhiJodHRwOi8vcm9vdC1jYS51ZXBhbHMuY29t
# L3Jvb3QuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQDA3Fb0UC0kuTKU6hAgqbAlJFQn
# k/dXMDUKPSoZFYn5T+Ha+Z/5QwOQ/hPHAnRN4ozHXW1S3KPCTKwh60fLD/WRHinj
# 6L7RBUGgI8FtShdkl0MqPfdADNJOUKNpIkgbmbH5I5crXkVVwSdGpNHMK/zgiumn
# 6tJL3R0XAkyibzLrUE1ud9n2AmKLppBuHZO6L2/wP0rn2K2rM4IxwhWXJlB7r428
# +RU6vQGcNYwO1Ppes+1nEV8Ss0zMV9qC9C5uWUf5Tb/OPgA6AHSzqzdn1n/EsAXK
# vvSRfaQBiSMu99cBz4/t4bF9ziXhK4+1jpZ81LYA47udqouUtIvk3Q0aDdxkU602
# BUktGafM3QVVokOE8svr7DNFyFNos6xOteiwhlQ/I1zn5ZJhQfViBaC6KSZACmEe
# gpy4GfRyAbHgRL7/A4dWf2/CFfqHv5UZktMqTn7l6U4ARgiJkqYREiBG0iVW8Vyn
# 5ZbCEX9UOtxCNAIU54ojga52Yx1ZjrtBWRddq6vRyHzpZZm2deovpJgMlmhhOnpq
# ALQroJ16Wg3Gwk/UCDmV50l3O21tQujtPdUO1qQmgKQMra5X0mBzmHRqBfdc8SNP
# hEGIGK/k1WFQODdAlWmt34SyCnJBBAS27MWOCIaLbxwxjDNnWczSP2UEwsLBx8lD
# xS9QeAyovfsiSynRoTCCBmYwggROoAMCAQICE1cAAAgL6kCys59OjTEAAAAACAsw
# DQYJKoZIhvcNAQELBQAwFzEVMBMGA1UEAxMMdWVwYWxzLXN1YmNhMB4XDTE3MDUx
# MDEwNDgyNFoXDTE4MDUxMDEwNDgyNFowdDETMBEGCgmSJomT8ixkARkWA2NvbTEW
# MBQGCgmSJomT8ixkARkWBnVlcGFsczEVMBMGA1UECwwMVUVQQUxTX1VzZXJzMRUw
# EwYDVQQLDAxVc2Vyc19BZG1pbnMxFzAVBgNVBAMTDk1hcnRpbiBWb2d3ZWxsMIIB
# IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxiFq8guC/yGsdVEtBWrSN8C3
# z6ZnstZF/nINfm/8PhWi91/JfvrYWHwMfoZzOxOyFp7YKrljL2H20+8waTS54FZa
# rAFSaYNNFAiTYSacOb1YKB58EY5vTirtAr1/C3s8EMMEaUhJS05B2tTyjU3Xb/X6
# 5J12ilkSmGXIDC7oL+w8ctoHfrpm++D97qCmHkM9hdX3yvNJWgPFoxFMsKN3rrVh
# l/S5irarYqIGD5W5MkrFH/XG95w3c9VWPEGRkwISNn7Rf3LETsB5zvMXRA6RbjNh
# zA9xoJ0HjxMdTloYEkVsZORqcH24SPZWyU4sx+l0g31Z3ZOSbzDz0ypzX6KE4QID
# AQABo4ICTDCCAkgwJQYJKwYBBAGCNxQCBBgeFgBDAG8AZABlAFMAaQBnAG4AaQBu
# AGcwEwYDVR0lBAwwCgYIKwYBBQUHAwMwDgYDVR0PAQH/BAQDAgeAMB0GA1UdDgQW
# BBQDIWPrljeRgkfPJaVLoUcbF/cxGTAfBgNVHSMEGDAWgBTLk78HrxA8eM3eIF0r
# BL84Ho3pmzCByQYDVR0fBIHBMIG+MIG7oIG4oIG1hoGybGRhcDovLy9DTj11ZXBh
# bHMtc3ViY2EsQ049VUxUUkE1MSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2Vy
# dmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz11ZXBhbHMsREM9
# Y29tP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3Q/YmFzZT9vYmplY3RDbGFzcz1j
# UkxEaXN0cmlidXRpb25Qb2ludDCBvQYIKwYBBQUHAQEEgbAwga0wgaoGCCsGAQUF
# BzAChoGdbGRhcDovLy9DTj11ZXBhbHMtc3ViY2EsQ049QUlBLENOPVB1YmxpYyUy
# MEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9
# dWVwYWxzLERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2Vy
# dGlmaWNhdGlvbkF1dGhvcml0eTAuBgNVHREEJzAloCMGCisGAQQBgjcUAgOgFQwT
# bXZvZ3dlbGxAdWVwYWxzLmNvbTANBgkqhkiG9w0BAQsFAAOCAgEAh063vJUgDKQv
# me+aMKfgzfKtl6+iI73YKynm6bkFc/zciMIFZiFcJRyi8yMT8heOmkm3i75TBDZG
# jBUYauopzZWMMwqn0TBSLsFKrtblPXYhCDArcp9Mn0HZvhIIa/9tY8R9xg57UJnc
# 4dokTh5ElfHn9rCrPPIQUJe5cryg2IsHouzfW30EzoHhp5io1iLf3xwAxWZEegEi
# 9EUVjhbzNBW5VV7oa1bKYeDtitvTpXxFUQ7tbZEPY9tYxvwwoXjqRCs4ZfPQZeP1
# xs1Hl/szgfTvyIdEZhzfUAAxL/YJlmukcPl/U+9Zojlve1zc04AfAeuN5QnGoFa1
# 3w3wrDTrNA7haoWU/B1lKd9xuzkc3nBhx6k/s8elBAkHB0LlZS89mJgOKgLyS5GM
# CgeiFeVL3YgcVgb76BBIQ8JceYonqrLrng3J9XEqe6L5AYZp6zir0MoUcPZT+V1P
# dcyBMO80f2tIp89KSxL4zZwoVczS7yMm7yidRPTETNOJkiK1OkI2M4/bPp6uzuSb
# vbjYukjzjxeZlikIWw9Ty2aIeAMyAurOCK19or2+NdXLAleUEyi+2v5FsqIaHBlN
# OHrEfjEhiz2MDYRayPLhAsSVzCkkRzoqVBSikjeds69WMSUP0RWGTRV47PMJwxz4
# pMj5O51+t5b4pmL59ErVUAsGQYRZ2zQxggHPMIIBywIBATAuMBcxFTATBgNVBAMT
# DHVlcGFscy1zdWJjYQITVwAACAvqQLKzn06NMQAAAAAICzAJBgUrDgMCGgUAoHgw
# GAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGC
# NwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQx
# FgQU8jzsQfRFmu9cwGscO6Ym8stgz6MwDQYJKoZIhvcNAQEBBQAEggEARaLd3c0m
# arnZCPYIKApmE8ahl8LA0CQDbZ3lGpEAirp1Kh+LP2kjxU8j1CjBSzFwYMGbIqfr
# UfXjjPcj1ZUkTxKoh6fHC5LC3wZPaViVb2aQ0o7cgNVj1RgzCQnJIhqAS+PEZT9u
# D1tASazYBPBs9GFq1M1a/TWjf/K2FINHgJPda6z9WJs+rrh4SkOVeVKktag+visy
# ttcezcLP9aUWjJHi+m5vE2fjdrRH5kvJ4E9HqHR/aqVcg/eXnOOlqPxrxy4nMylp
# QMtxS+L1TqSqNcZM9hvDE3I8X1saOzZqJJg/cGi8Un73/BzZ7KRVjqqPsuDbQWVO
# /O1z2quMPDpIqQ==
# SIG # End signature block
