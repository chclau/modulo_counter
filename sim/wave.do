onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_modulo_cnt/modulo_cnt_i/rst
add wave -noupdate /tb_modulo_cnt/modulo_cnt_i/clk
add wave -noupdate -radix unsigned /tb_modulo_cnt/modulo_cnt_i/cnt
add wave -noupdate /tb_modulo_cnt/modulo_cnt_i/en
add wave -noupdate -radix unsigned /tb_modulo_cnt/modulo_cnt_i/max_cnt
add wave -noupdate /tb_modulo_cnt/modulo_cnt_i/zero
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {506 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {1634063 ps}
