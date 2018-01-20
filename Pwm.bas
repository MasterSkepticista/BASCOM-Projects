'_______________________________________________________________________________
'Universal Algorithm with redundancy eliminator for 8 follower bot.
'MCU:                            ATmega8
'pin config sensor as follows:   [ D4-D5-D6-D7-B0-B1-B2-B3 ]
'motor config as follows         [ LEFT D0-B4; RIGHT D2-D3 ]
'Credits:                        16E044
'Flash usage:                    13% (avg)
'_______________________________________________________________________________

$regfile = "m8def.dat"

$crystal = 16000000
'$sim


'pin config sensor as follows:[ B0-B5-B4-B3-D4-D5-D6-D7 ]

Config Lcdpin = Pin , Db4 = Portc.2 , Db5 = Portc.3 , Db6 = Portc.4 , Db7 = Portc.5 , E = Portc.1 , Rs = Portc.0
Config Lcd = 16 * 2
'*******************************************************************************
Config Portb.0 = Input
Config Portb.5 = Input
Config Portb.4 = Input
Config Portd.3 = Input
Config Portd.4 = Input
Config Portd.5 = Input
Config Portd.6 = Input
Config Portd.7 = Input
'*******************************************************************************
L3 Alias Pind.4
L2 Alias Pind.5
L1 Alias Pind.6
F0 Alias Pind.7
F1 Alias Pinb.0
R1 Alias Pinb.5
R2 Alias Pinb.4
R3 Alias Pind.3

'*******************************************************************************

Declare Sub Refreshstate()
Declare Function Error_calc() As Integer


Lm Alias Pwm1a
Rm Alias Pwm1b

Dim I As Integer , J As Integer
Dim Sensor As Byte
Dim Currentpos As Integer , Basespeed As Double , Kp As Integer , Ki As Double , Kd As Integer
Dim Error As Integer , Correction As Double , Last_error As Integer
Dim P As Integer , Integral As Integer , Derivative As Integer , I_term As Double , D_term As Integer
Config Timer1 = Pwm , Pwm = 8 , Compare A Pwm = Clear Up , Compare B Pwm = Clear Up , Prescale = 256
Cls
Lcd "Ready"
Basespeed = 200
Kp = 30
Kd = 0
Ki = 0.55

Integral = 0
Last_error = 0
'*******************************************************************************
Do
   Cls
   Do
      Call Refreshstate()
      Cls
      Error = Error_calc()
      Lcd Error
         Integral = Integral + Error
   Derivative = Error - Last_error

   P = Error * Kp
   I_term = Integral * Ki
   D_term = Kd * Derivative
   Correction = P + I_term
   Correction = Correction + D_term

   Lm = Basespeed + Correction
   Rm = Basespeed - Correction


   Last_error = Error
   Loop
Loop
'*******************************************************************************



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

End Sub

Function Error_calc() As Integer
   Call Refreshstate()
   If Sensor.0 = 0 Then
      Error = -4
         Elseif Sensor.1 = 0 Then
      Error = -3
         Elseif Sensor.2 = 0 Then
      Error = -2
         Elseif Sensor.3 = 0 Then
         If Sensor.4 = 0 And Sensor.3 = 0 Then
            Error = 0
         Else
            Error = -1
         End If
         Elseif Sensor.4 = 0 Then
      Error = 1
         Elseif Sensor.5 = 0 Then
      Error = 2
         Elseif Sensor.6 = 0 Then
      Error = 3
         Elseif Sensor.7 = 0 Then
      Error = 4

       End If


  Error_calc = Error


End Function Error_calc()
