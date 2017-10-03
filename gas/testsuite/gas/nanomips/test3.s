	.data
data_label:
	.lcomm big_local_common,1000
	
	.text
text_label:
	nop32
	la	$4,data_label+0x1

# Force at least 8 (non-delay-slot) zero bytes, to make 'objdump' print ...
	.space  8
