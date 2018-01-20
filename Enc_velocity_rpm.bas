$regfile = "m8def.dat"
'$sim
$crystal = 16000000




Config Lcdpin = Pin , Db4 = Portc.2 , Db5 = Portc.3 , Db6 = Portc.4 , Db7 = Portc.5 , E = Portc.1 , Rs = Portc.0
Config Lcd = 16 * 2
Dim E As Byte

Dim F As Integer , B As Integer , Net As Integer

Enable Interrupts

Portd = &B0011
On Int0 Encode Nosave
Do



   Cls

   Lcd B ; ":" ; F
   Lowerline
   Net = F + B
   Lcd Net



  'Lcd "Displaced:" ; F

 Waitms 10
Loop





Encode:
E = Encoder(pind.2 , Pind.3 , Cw , Ccw , 0)
Return


Cw:
'Lcd F
Incr F
Return



Ccw:
Decr B
'Lcd B
Return

End
