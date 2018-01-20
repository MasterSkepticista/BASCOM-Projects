$regfile = "m128def.dat"
'$sim
$crystal = 16000000


Config Lcdpin = Pin , Db4 = Porta.5 , Db5 = Porta.6 , Db6 = Porta.7 , Db7 = Portg.2 , E = Porta.4 , Rs = Porta.3
Config Lcd = 16 * 2

Config Timer0 = Timer , Prescale = 1024
Dim S As Integer , Tcnt As Integer , H As Integer , M As Integer
Tcnt = 1
S = 1
Start Timer0
Enable Timer0
Enable Interrupts
Enable Int0
'On Int0 Int0_isr

On Ovf0 Tim0_isr
Do
Do
Loop Until Tcnt = 61
Cls
  Lcd H
  Lcd ":"
  Lcd M
  Lcd ":"
  Lcd S
  S = S + 1
  If S = 60 Then
   S = 0
   M = M + 1
   If M = 60 Then
      M = 0
      S = 0

      H = H + 1
      End If
   End If

Tcnt = 0
Loop
Tim0_isr:
Tcnt = Tcnt + 1

Return

Int0_isr:
'Lowerline:
'Cls
'Lcd "Active ISR"

Return