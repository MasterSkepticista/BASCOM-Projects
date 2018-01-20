'_______________________________________________________________________________
'Universal Algorithm with redundancy eliminator for 8 follower bot.
'MCU:                            ATmega8
'pin config sensor as follows:   [ D4-D5-D6-D7-B0-B1-B2-B3 ]
'motor config as follows         [ LEFT D0-B4; RIGHT D2-D3 ]
'Credits:                        16E044
'Flash usage:                    25% (avg)
'_______________________________________________________________________________

$regfile "m8def.dat"
$crystal = 16000000
'$sim


Config Portb.0 = Input
Config Portb.1 = Input
Config Portb.2 = Input
Config Portb.5 = Input                                      'b3
Config Portd.4 = Input
Config Portd.5 = Input
Config Portd.6 = Input
Config Portd.7 = Input
Config Timer1 = Timer , Prescale = 1024
Stop Timer1
Config Portb.4 = Output
Config Portd.0 = Output
Config Portd.2 = Output
Config Portd.3 = Output

Config Lcdpin = Pin , Db4 = Portc.2 , Db5 = Portc.3 , Db6 = Portc.4 , Db7 = Portc.5 , E = Portc.1 , Rs = Portc.0
Config Lcd = 16 * 2

Declare Sub Turnleft()
Declare Sub Turnright()
Declare Sub Axial_left()
Declare Sub Axial_right()
Declare Sub Forward()
Declare Sub Stp()
Declare Sub Refreshstate()
Declare Sub Juncright()
Declare Sub Juncleft()
Declare Sub Navigate()
Declare Sub Recovery()
Declare Sub Reverse()
Declare Sub Routefix()

L3 Alias Pind.4
L2 Alias Pind.5
L1 Alias Pind.6
F0 Alias Pind.7
F1 Alias Pinb.0
R1 Alias Pinb.1
R2 Alias Pinb.2
R3 Alias Pinb.5
Dim Trace As Bit
Dim Last_motor As Bit
Dim Sensor As Byte
Dim Turns_counter As Integer
Dim Last_sensor As Integer
Dim Online As Integer
Dim Direction As Bit
Dim Ignorejn As Bit
Dim Route As Byte
Dim I As Integer
Dim J As Integer
I = 0
Direction = 1
Last_sensor = 0
Turns_counter = 0
Ignorejn = 0
Trace = 0
Last_motor = 0

'Start core loops here----------------------------------------------------------

Do
Retrace:
Sensor.7 = R3
Sensor.6 = R2
Sensor.5 = R1
Sensor.4 = F1
Sensor.3 = F0
Sensor.2 = L1
Sensor.1 = L2
Sensor.0 = L3
Cls
   Lcd L3
   Lcd L2
   Lcd L1
   Lcd F0
   Lcd F1
   Lcd R1
   Lcd R2
   Lcd R3

Lowerline :

Select Case Sensor


 'Individual bitconfigs

   Case &B01111111 : Online = 1
                     Call Turnleft()
   Case &B10111111 : Online = 1
                     Call Turnleft()
   Case &B11011111 : Online = 1
                      Call Forward()
   Case &B11101111 : Online = 1
                     Call Forward()
   Case &B11110111 : Online = 1
                     Call Forward()
   Case &B11111011 : Online = 1
                     Call Forward()
   Case &B11111101 : Online = 1
                     Call Turnright()
   Case &B11111110 : Online = 1
                     Call Turnright()

'Dual bit configs
   Case &B11100111 : Last_sensor = 0
                     Online = 1


                     Call Forward()
   Case &B11001111 : Last_sensor = 0
                     Online = 1
                     Cls
                     Call Forward()
   Case &B11110011 : Last_sensor = 0
                     Online = 1
                     Cls
                     Call Forward()
   Case &B11001111 : Last_sensor = 0
                     Online = 1
                     Cls
                     Call Forward()
   Case &B00111111 : Last_sensor = 2
                     Online = 1
                      Call Turnleft()
   Case &B11111100 : Last_sensor = 1
                     Online = 1
                     Cls
                     Call Turnright()

   Case &B10011111 : Last_sensor = 0
                     Online = 1
                     Call Forward()
   Case &B11111001 : Last_sensor = 0
                     Cls
                     Call Forward()

   Case &B11111111 : Online = 0
                     Call Recovery()
   Case &B00000000 : Cls
                     Lcd Turns_counter
                     If Trace = 0 Then
                        If Ignorejn = 0 Then
                           Incr Turns_counter
                            If Turns_counter = 8 Then
                              Start Timer1
                            End If
                             If Timer1 > 15625 Then
                                 Exit Do
                        End If
                           Direction = Not Direction
                           Online = 1
                           Call Stp()
                           Last_sensor = 0
                           Call Navigate()
                           If Direction = 1 Then
                              Route.i = 0
                           Else
                              Route.i = 1
                           End If

                              Incr I
                        Elseif Ignorejn = 1 Then
                              Call Forward()
                              Waitms 250
                              Ignorejn = 0
                        End If
                     Elseif Trace = 1 Then
                        If Route.i = 0 Then
                           Call Juncleft()
                           Incr I
                           Incr Turns_counter
                        Else
                           Call Juncright()
                           Incr I
                           Incr Turns_counter
                        End If
                     End If
   Case Else : Call Forward()


End Select

Loop

Call Stp()


Call Routefix()
Call Reverse()
Wait 1
'-------------------------------------------PART2/2,NAVIGATE BY MEMORY------------------------------

  Trace = 1
  Turns_counter = 1
  I = 0
  Goto Retrace:
  Call Stp()


Do
Loop
End


'------------------------------------------SUBROUTINE SECTIONS. DO NOT TOUCH!!!
Sub Refreshstate()
Sensor.7 = L3
Sensor.6 = L2
Sensor.5 = L1
Sensor.4 = F0
Sensor.3 = F1
Sensor.2 = R1
Sensor.1 = R2
Sensor.0 = R3
Return
End Sub

'-------------------------------------------------------------------------------
Sub Forward()
   Set Portd.0
   Reset Portb.4
   Cls

   Set Portd.2
   Reset Portd.3

End Sub
'-------------------------------------------------------------------------------
Sub Stp()
   Reset Portd.2
   Reset Portd.3

   Reset Portd.0
   Reset Portb.4
End Sub
'-------------------------------------------------------------------------------
Sub Turnleft()

   Set Portd.2
   Reset Portd.3
   Cls
   Reset Portd.0
   Reset Portb.4
End Sub
'-------------------------------------------------------------------------------
Sub Axial_right()

   Reset Portd.2
   Set Portd.3
   Cls
   Set Portd.0
   Reset Portb.4
End Sub
'-------------------------------------------------------------------------------
Sub Turnright()
   Reset Portd.2
   Reset Portd.3
   Cls

   Set Portd.0
   Reset Portb.4
End Sub
'-------------------------------------------------------------------------------
Sub Axial_left()
   Set Portd.2
   Reset Portd.3
   Cls
   Reset Portd.0
   Set Portb.4
End Sub
'-------------------------------------------------------------------------------
Sub Juncleft()
   Last_motor = 0
   Do
           Call Turnleft()
           Call Refreshstate()

   Loop Until Sensor = &B11111110
End Sub
'-------------------------------------------------------------------------------
Sub Juncright()
   Last_motor = 1
   Do
         Call Turnright()
         Call Refreshstate()

   Loop Until Sensor = &B01111111

End Sub
'-------------------------------------------------------------------------------
Sub Navigate()
If Direction = 1 Then
   Call Juncleft()
Elseif Direction = 0 Then
   Call Juncright()

End If
End Sub
'-------------------------------------------------------------------------------
Sub Recovery()
  Do
   Do
      Call Axial_right()
      Call Refreshstate()
   Loop Until Sensor = &B10011111

   Do
      Call Refreshstate()
      Call Turnleft()
   Loop Until Sensor = &B11100111
  Loop Until Sensor = &B11100111

   Ignorejn = 1

Direction = Not Direction


End Sub
'-------------------------------------------------------------------------------
Sub Reverse()
   Set Portb.4
   Set Portd.3
   Reset Portd.0
   Reset Portd.2
End Sub

'-------------------------------------------------------------------------------
Sub Routefix()
I = 0
J = 0
Do
   J = I + 1
   If Route.i = Route.j Then
      Toggle Route.i
      Incr I
   Else
      Incr I
   End If
Loop Until I = 7


End Sub
'-------------------------------------------------------------------------------






































































































































'Codeauth:KaranShah16e044