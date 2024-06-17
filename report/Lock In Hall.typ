#import "template.typ": *
#import "@preview/tablex:0.0.8": *
#let th=[#math.theta]
#let ll=[#sym.angle.l]
#let rr=[#sym.angle.r]
#let times="×"
#let pi = "π"
#let neq = "≠"
#show: project.with(
  title: "Lock In Hall",
  authors: (
    (name: "Seunghyun Moon", email: "shmoon232@snu.ac.kr", affiliation: "Department of Physics and Astronomy, Seoul National University,\nSeoul, 08826 South Korea"),
  ),
  abstract: "이 실험에서는 Lock-In Detector를 이용한 홀 소자를 사용하여 자석에서 떨어진 거리에 대한 자기장을 측정하는 과정을 통해 자석의 성질을 측정하는 실험을 수행한다. 이를 위해 Lock-In Amplifier의 Calibration을 수행하는데, Preamp의 Gain과 Phase Shifter의 Frequency Dependency를 측정하였다. 이후에는 DBM을 이용한 Lock-In Detection을 수행하였으며, Low Pass Filter의 Gain을 측정하였다. 그리고 각 과정에서 어떠한 영역에서 본 장비가 잘 작동하고 어떠한 영역에서 작동하기 어려운지 정성적인, 정량적인 분석을 수행하였다. 그 뒤, 신호와 노이즈를 섞은 값을 FFT를 통한 분석과 Lock-In Deteocter를 이용한 Signal Detection을 수행하였다. 이때의 노이즈는 AC Noise와 DC Offset 모두 존재하였다. 이렇게 Lock-In Detection을 수행할 수 있게 된 뒤에 Hall Effect를 이용한 홀 소자를 통하여 자기장을 측정할 수 있게되면서 주어진 자석의 자기 쌍극자 모멘트를 계산해 보고 자성을 계산하여 실제 참값인 0.75J/T과 2.0J/T 사이에 모든 예측치인 1.27, 1.59, 0.76J/T가 들어감을 확인할 수 있었다."+"\n"+text(weight: "bold")[Keywords: ]
  +"Lock-In Amplifier, Hall Effect, Magnetic Dipole Moment, Low Pass Filter",
  date: "May 23, 2024",
)

= Introduction

== Lock-In Amplifier

Lock-In Amplifier(Detector)는 Noise가 섞인 전기 신호에서 원하는 주파수의 세기만을 검출해 내는 회로로, Noise가 섞인 신호를 처리하는 데에 이용된다 @stimpson2019open@devore2016improving. 이러한 과정을 수행하기 위한 이론적 기반은 다음과 같은 가정에서 출발한다. 우선 두 개의 신호 $A_a sin omega_a t$와 $A_b sin omega_b t$가 있다고 가정하자. 이때 두 신호의 곱을 구하면 다음과 같다.
$
A_a sin omega_a t A_b sin omega_b t \
= 1/2 A_a A_b [cos(omega_a - omega_b)t - cos(omega_a + omega_b)t]
$

여기서 $omega_a neq omega_b $이면, 위 식은 시간에 대한 평균이 0이 되며, 이는 두 신호가 서로 다른 주파수를 가질 때에는 서로 영향을 주지 않는다는 것을 의미한다. 반대로 $omega_a = omega_b$일 때에는 시간에 대한 평균이 $1/2 A_a A_b$가 되며, 이는 두 신호가 같은 주파수를 가질 때에는 서로 영향을 주는 것을 의미한다. 이러한 성질을 이용하여 Lock-In Amplifier는 Noise가 섞인 신호를 처리할 수 있다. 여기서 중요한 점은 Noise가 섞인 신호를 처리할 때 Noise의 주파수가 측정하고자 하는 신호의 주파수와 같으면 함께 처리되어 원하는 신호를 검출해 내기 어렵다는 것이다. 따라서 Lock-In Amplifier는 Noise가 섞인 신호를 처리할 때에는 Noise의 주파수와 다른 주파수를 가지는 신호를 검출해 내는 데에 이용된다.

이러한 Lock-In Amplifier를 위해서 Double Balanced Mixer(DBM)이라는 장치가 사용된다. DBM은 두 개의 신호를 곱하는 장치로, 위에서 언급한 두 신호의 곱을 구하는 과정을 수행한다. 이때 DBM의 출력은 위에서 언급한 두 신호의 곱의 평균값을 나타내며, 이는 원하는 신호의 세기를 나타낸다. 여기서 DBM의 회로도는 다음 @dbm_circuit 같다@devore2016improving.

#figure(
  image("images/DBM.png"),
  caption: "Circuit Diagram of DBM"
) <dbm_circuit>

== Low Pass Filter

Lock-In Amplifier에서는 Low Pass Filter가 사용된다. Low Pass Filter는 주파수가 일정 값 이상인 신호를 걸러내는 장치로, Noise가 섞인 신호를 처리할 때에는 Noise의 주파수가 일정 값 이상인 신호를 걸러내어 원하는 신호를 검출해 내는 데에 이용된다. 이때 Low Pass Filter의 Roll-Off Rate와 Time Constant는 Filter의 특성을 결정하는 요소이다. Roll-Off Rate은 Filter가 걸러질 주파수에 도달했을 때에 얼마나 빠르게 걸러지는지를 나타내며, Time Constant는 어떤 주파수부터 걸러지기 시작하는지를 나타낸다. 이러한 두 요소를 조합하여 Filter의 특성을 결정하며, 이를 이용하여 Noise가 섞인 신호를 처리할 때에는 Noise의 주파수가 일정 값 이상인 신호를 걸러내어 원하는 신호를 검출해 내는 데에 이용된다. @karki2000active

== Hall Effect

Hall Effect는 시료에 자기장을 가하고, 이 시료에 전류를 흘려보내었을 때, 시료의 평면에 수직인 방향으로 전압이 발생하는 현상을 말한다. 이때 발생하는 전압은 다음과 같이 표현된다.

$
V_H = - R_H i B d/A
$

여기서 $i$는 전류의 세기, $B$는 자기장의 세기, $d$는 시료의 폭, $A$는 시료의 평면적, $R_H$는 Hall Coefficient이다. 이때 Hall Coefficient는 시료의 물성에 의존하는 상수로, $1/(n e)$로 정의된다. 여기서 $n$은 전하밀도, $e$는 전자의 전하이다. 이러한 Hall Effect는 자기장을 측정하는 데에 이용되며, 이 성질을 이용해서 자기장을 측정하는 소자를 설계할 수 있다.

== Magnetic Dipole Moment

자기홀극이 존재하지 않는 것은 잘 알려져 있다. 따라서 자기장을 만드는 가장 기초적인 단위는 자기 쌍극자 모멘텀이다. 자기 쌍극자 모멘텀은 전류 $I$가 흐르는 루프가 단면적 $A$를 가질 때, $arrow(m) = I arrow(A)$으로 정의된다. 자기 쌍극자 모멘텀은 주위에 자기장을 만드는데, 이때 만드는 자기장은 전기 쌍극자 모멘트와 유사하게 아래와 같이 얻어진다.

$
arrow(B) = mu_0 / (4pi r^3) [3 (arrow(m) dot hat(r)) hat(r) - arrow(m)]
$

= Experimental Method

== Apparatus

본 실험은 TeachSpin 사의 Signal Processor/Lock-In Amplifier 키트@TeachSpinLockIn, Protek 사의 GD-0020N 함수 발생기@Protek, Tektronix 사의 DPO2024 오실로스코프@Tektronix, 그리고 Matrix Opto Co., Ltd 사의 MG910 GaAs 홀 소자@MatrixOpto 를 사용하였다. 각 장비 간의 연결을 위해서는 BNC 케이블과 BNC tee를 이용하였다. 각 실험에서는 Signal Processor/Lock-In Amplifier 키트 위의 다양한 장치를 사용하였다. 본 실험에서는 Preamplifier(Preamp), Lock-in/amplitude detector, Low-pass filter amplitude, 그리고 Phase shifter를 사용했다. 키트에 Reference Oscillator가 함수 발생기와 같은 역할을 할 수 있으나 해당 장비의 성능이 좋지 않아 함수 발생기를 사용한다.

== Calibration of the Lock-In Amplifier

Lock-In detection을 위해 사용하는 장비들이 잘 작동하는 조건을 찾아가는 과정으로, Apparatus에서 소개한 장비들의 특성을 분석해보는 과정을 가진다.

=== Frequency Dependency of the Preamp Gain

Preamp의 Gain을 다양하게 설정할 수 있는데, 이때 입력 신호의 주파수에 따라서 설정한 Gain에서 벗어난 다른 값이 나타날 수 있으며, 어떤 주파수/Gain에서 의도된 값이 나타나는지 확인하여 실험이 가능한 영역을 설정할 수 있다. 본 실험에서는 Preamp의 Gain을 1, 2, 5, 10, 20dB으로 설정하고 1kHz 부터 2MHz까지 값이 변화하는 영역에서는 더 상세하게 측정하는 실험을 진행하였다. 또한, 3dB Frequency를 측정하여 Preamp가 잘 작동한다고 볼 수 있는 주파수 범위를 측정하였다.

=== Frequency Dependency of the Phase Shift

Phase Shifter는 입력 신호의 위상을 조절하는 장치이나, 주파수 영역에 따라 Phase Shift가 의도된 대로 일어나지 않을 수 있기에 해당 부분을 측정한다. 본 실험에서는 주파수 영역에 따라 Phase Shift가 어떻게 나타나는지를 확인하여 Linearity를 벗어나는 영역을 확인하고, 설정한 Phase Shift에 따라 오차인 Delta가 어떻게 변화하는지를 측정한다.

=== DBM Experiment of the Lock-In Amplifier

Lock-In Detecor에 Input Signal과 Reference Signal의 위상차를 0, #pi/2. #pi, 3#pi/2로 설정하여 원본 신호와 어떠한 차이가 발생하는지 개형을 확인한다. 여기서의 위상차는 설정한 값이 아닌 오실로스코프를 통해 측정한 값으로 설정한다.

=== Gain of the Low Pass Filter

Low Pass Filter에서 설정 가능한 Roll-Off Rate과 Time Constant 조합에 대해 Gain-Frequency그래프를 그려 설정한 값들이 정상적으로 나타나는지를 확인한다. Roll-Off Rate는 6, 12dB/octave로 설정하였으며, Time Constant는 0.3, 0.1, 0.03s로 설정하였다.

== Lock-In Detection

신호에 직접 Noise를 섞은 뒤에 Lock-In Detection을 수행하여 기존의 Signal이 잘 검출되는지를 확인한다.

=== Spetrum Examination with FFT

함수발생기로 Signal을 생성한 뒤, 키트의 Noise Generator를 이용하여 Signal을 변형시킨다. 이후 FFT를 통해 변형된 Signal의 Spectrum을 확인한다. 이 과정을 통하여 Lock-In Amplifier에 입력되는 Signal이 어떠한 형태를 가지는지를 확인해 볼 수 있다.

=== Signal Detection with Lock-In Amplifier

본 실험에서는 위에서 사용한 Signal과 Noise의 조합을 Lock-In Amplifier에 입력하여 Signal이 잘 검출되는지를 확인한다. 이때, Signal의 주파수와 Noise의 주파수를 다르게 설정하여 Signal이 잘 검출되는지를 확인한다.

=== DC offset stability of the Lock-In Amplifier

Noise에 DC Offset이 있을 때에도 잘 작동하는지를 확인하기 위해 Noise를 DC Offset을 준 상태로 생성하고 Offset을 바꾸어 가며 Lock-In Detector의 출력을 확인한다.

== Measurement of the Dipole Moment

Lock-In Detection을 통해서 실제 물리적인 현상에 대한 측정을 진행한다. 홀 소자를 이용하여 자기장을 측정할 수 있기에 자석이 만드는 자기장을 측정하고 이 과정에서 발생하는 신호를 Lock-In Deteocter를 통해 측정한다. 홀 소자의 자석으로부터의 위치를 바꾸어 가면서 실험을 수행하고, 자석에 대해 알고 있는 정보로부터 실험 결과를 추정하고 비교한다.

= Results

== Calibration of the Lock-In Amplifier

=== Frequency Dependency of the Preamp Gain <A-1>

Preamp Gain의 진동수에 따른 값은 아래와 같이 나타났다. 각 그래프는 Gain이 1, 2, 5, 10, 20dB일 때의 값이다.

#{
  for i in (1, 2, 5, 10, 20) {
    figure(
      image("images/A-1/gain"+str(i)+".png"),
      caption: "Frequency Dependency of the Preamp with "+str(i)+"dB Gain"
    )
  } 
} 

위의 그래프들과 같이 Preamp의 Gain이 설정된 값을 벗어나는 시점에는 Gain이 Frequency의 log에 비례하는 형태로 감소하는 것을 확인할 수 있었다. 이를 이용한 interpolation을 통해 3dB Frequency를 측정하였다. 이렇게 얻은 3dB Frequency는 모두 450kHz보다 오차범위 외에서 큰 것으로 나타났기에 450kHz 이하의 주파수에서는 Preamp가 잘 작동한다고 볼 수 있다.

=== Frequency Dependency of the Phase Shift <A-2>

#figure(
  image("images/A-2/Anomalous_Phase-Frequency.png"),
  caption: "Anomalous Phase Shift on Frequency"
) <phase_shift>
위 @phase_shift 의 그래프는 주파수에 따른 Phase shift의 값을 구한 결과로, 진동수와 Phase Shift가 선형적인 관계를 가진다는 것을 확인할 수 있다. 그러나 일부 영역에서 이러한 선형성이 깨지는 것을 확인할 수 있는데, 해당 영역이 Phase Shifter가 잘 작동하지 않는 영역이라고 볼 수 있다. 그러나 위 실험에서 얻은 450kHz 이하의 주파수에서는 Phase Shifter가 잘 작동한다고 볼 수 있다. Phase Shifter에서 설정한 값에 따른 오차를 측정한 결과는 아래 @delta_phase 와 같다.

#figure(
  image("images/A-2/Delta-PhaseShift.png"),
  caption: "Delta of Phase Shift"
) <delta_phase>

위 @delta_phase 는 Phase Shifter에서 설정한 값에 따른 오차를 나타낸 그래프로, 설정한 값에 따라 오차가 어떻게 변화하는지를 확인할 수 있다. 여기서 오차가 설정한 값과 선형성을 가지며, 설정한 값이 커질수록 오차가 커지는 것을 확인할 수 있다. 또한 기울기가 -1에 매우 가까운 것으로부터 특정 주파수에서는 Phase Shifter가 Shift 하는 값이 설정한 값과 관계없이 일정한 것으로 유추할 수 있고, 이때의 값은 -10rad 부근인 것으로 추정된다. 

=== DBM Experiment of the Lock-In Amplifier <A-3>

#figure(
  image("images/A-3.png"),
  caption: "DBM Experiment of the Lock-In Amplifier"
) <dbm>

위 @dbm 은 Lock-In Detector에 Input Signal과 Reference Signal의 위상차를 왼쪽 위부터 0, #pi/2. #pi, 3#pi/2로 설정하여 원본 신호와 어떠한 차이가 발생하는지를 개형을 나타낸 그래프이다. 파란색 그래프는 원래 신호이며, 노란색 그래프는 DBM을 통해 변환된 신호이다. 우선 모든 그래프가 원래 신호에서 절반을 반복하는 것과 같은 형태를 가지는 것을 확인할 수 있다. 여기서 절반을 취할 위치를 위상차의 변화를 통해서 얻어낸 것으로 해석할 수 있다. 이에 위상차가 없는 왼쪽 위의 그래프에서는 $|sin omega t|$의 형태를 가지며, 이는 0부터 #pi 까지의 그래프를 그대로 반복한 것과 같은 형태이다. 그리고 두 번째 그래프는 #pi/2만큼 이동한 경우에 해당하는 것으로, -#pi/2부터 #pi/2까지의 그래프를 반복한 것과 같은 형태를 가진다. 이러한 과정으로 위상차에 따른 변화를 확인할 수 있다. 또, DBM이 의도된 대로 작동한다는 것을 확인할 수 있다.


=== Gain of the Low Pass Filter <A-4>

Low-pass Filter가 작동하는 Cutoff Frequency를 측정한 결과는 아래와 같다. 여기서 Roll-Off Rate는 6, 12dB/octave로 설정하였으며, Time Constant는 0.3, 0.1, 0.03s로 설정하였다.

#figure(
  image("images/A-4/6.png"),
  caption: "Gain-Frequency Graph with 6dB/octave Roll-Off Rate"
)
#figure(
  image("images/A-4/12.png"),
  caption: "Gain-Frequency Graph with 12dB/octave Roll-Off Rate"
)

== Lock-In Detection

=== Spetrum Examination with FFT <B-1>

아래 그래프들은 함수 발생기로 Signal을 생성한 뒤, 키트의 Noise Generator를 이용하여 Signal을 변형시킨 후 FFT를 통해 변형된 Signal의 Spectrum을 확인한 결과이다. 이때 FFT는 오실로스코프에 내장된 FFT 기능을 활용하였다. 1kHz로 진동수를 고정한 환경에서 Noise를 바꾸어 가며 확인하였다.

#{
  for i in (2, 3, 4) {
    figure(
      image("images/B-1/1kHz_100mV_10e-"+str(i)+"_FFT_2.PNG"),
      caption: "FFT of Signal with Noise 1e-"+str(i)+" at 1kHz"
    )
  }
}

위 그래프들에서 확인할 수 있는 노란색 신호가 들어온 신호이고 이를 FFT를 통해 분석한 결과가 하단의 빨간색 스펙트럼이다. 이때 스펙트럼에서 보이는 좌측의 Peak가 올바른 주파수를 나타내는 것으로 확인할 수 있으며, 여기서 Noise가 큰 환경에서는 노란색 그래프의 유동이 큰 동시에 스펙트럼의 유동도 비교적 큰 것을 확인할 수 있다. 이러한 과정을 통해서 Lock-In Amplifier에 입력될 Signal이 어떠한 형태를 가지는지를 확인할 수 있다.

#{
  figure(
    image("images/B-1/10kHz_10e-4_FFT.PNG"),
    caption: "FFT of Signal at 10kHz"
  )
  figure(
    image("images/B-1/100kHz_10e-4_FFT.PNG"),
    caption: "FFT of Signal at 100kHz"
  )
  figure(
    image("images/B-1/1MHz_10e-4_FFT.PNG"),
    caption: "FFT of Signal at 1MHz"
  )
}

위 그래프들은 진동수를 바꾸어 가며 FFT를 수행했을 때에 올바르게 진행되는지를 확인한 과정으로, 10kHz와 100kHz에서는 올바른 Peak를 명확하게 확인할 수 있었으나 1MHz에서는 비교적 명확하지 못한 Peak를 얻게 되었다. 따라서 1MHz에서는 Signal이 비교적 잘 검출되지 못한다는 것을 확인할 수 있었다.

=== Signal Detection with Lock-In Amplifier <B-2>

Lock-In Amplifier의 Signal Detection을 위해 Signal과 Noise를 조합하여 실험을 진행했다. 이때 Noise의 세기를 0.1, 0.001, 0.00001로 바꾸어 가며, Phase의 변화에 대해 실험을 진행하였다.

#{
  for i in (1, 3, 5) {
    figure(
      image("images/B-2/1e-"+str(i)+".png"),
      caption: "Signal Detection with Noise 1e-"+str(i)
    )
  }
}

위 그래프와 같이 Phase difference에 대해 Lock-In Output을 측정해 낼 수 있었고, 이때의 그래프는 예상되는 sin 형태의 그래프와 상당히 잘 맞는 것을 보여주었다. 위 그래프들을 모아서 다시 정리하면 아래 @signal_detection 과 같다.

#figure(
  image("images/B-2/all.png"),
  caption: "Signal Detection with Noise"
) <signal_detection>

각 S/N의 값에서 Amplify 되어 나온 Lock-In Output을 측정하여 모은 그래프는 아래 @amplified 와 같다.

#figure(
  image("images/B-2/amp.png"),
  caption: "Lock-In Output Size to S/N"
) <amplified>

위 @amplified 와 같이 S/N과 관계 없이 매우 일정한 값을 나타내고 있음을 확인할 수 있다.


=== DC offset stability of the Lock-In Amplifier <B-3>

#figure(
  image("images/B-3.png"),
  caption: "DC Offset Stability of the Lock-In Amplifier"
) <dc_offset>

위 @dc_offset 은 Noise에 DC Offset이 있는 경우에 시간 평균을 냈을 때에 사라지는 원리로 측정되지 않는다는 것을 확인하는 실험으로, 위 @dc_offset 과 같이 Offset의 세기가 변하지만 Output의 세기는 변하지 않는다는 것으로부터 

== Measurement of the Dipole Moment <C>

#{
  for i in ("A", "B", "C") {
    figure(
      image("images/C/"+i+".png"),
      caption: "Magnetic Field From Side "+i
    )
  }
}

위 그래프들은 네오디뮴 자석이 만드는 자기장을 네오디뮴 자석으로부터 떨어진 거리에 대해 자기장의 세기를 측정한 결과이다. 여기서의 Fitting은 네오디뮴 자석의 형태를 고려하여 계산한 결과이다. 이러한 과정을 통해 자기장의 세기를 측정하고, 이를 이용하여 자기 쌍극자 모멘트를 계산할 수 있다.


= Discussion

== Calibration of the Lock-In Amplifier

=== Frequency Dependency of the Preamp Gain

Preamp Gain의 진동수에 따른 값을 Gain이 1, 2, 5, 10, 20dB의 값으로 설정하였을 때에 위 @A-1 에서 보이는 결과와 같이 일정 시점부터 선형성을 보여주며, interpolation을 통하여 3dB frequency를 얻을 수 있었다. 여기서 나타나는 선형성의 기울기는 frequency가 높아짐에 따라 Gain이 감소하는 것으로 설정된 Gain과 무관해야 하는데, 실제로 모두 대략적으로 -30 dB/decade의 기울기를 가지는 것으로 나타났다. 또, 각각에 대해 모두 $R^2$이 매우 높게 나오기에 믿을만한 결과라고 생각할 수 있다. 다만 3dB Frequency의 값은 Gain의 값이 클수록 비교적 작게 나타나는 경향성을 보였는데, 이는 freqeuncy가 클수록 파동이 더 많은 에너지를 담고 있고, Gain의 값이 크면 이를 더욱 더 많이 증폭해야 하기 때문에 높은 Gain에서는 먼저 Roll-Off가 일어나는 것으로 추정된다.

조금 더 정확하게 말하자면, Preamp는 내부적으로 OP Amp를 이용하여 증폭을 수행하는데, OP Amp가 증폭하는 과정에서 결과값으로 나올 수 있는 기울기의 최댓값이 존재한다. 따라서 증폭될 기울기가 $s$ 라고 할때 이의 최댓값은 일정하며, 주어지는 신호의 기울기는 주파수 $f$에 비례한다. 따라서 설정된 Gain 값의 차이로 인해 발생한 전압 진폭 비율에 비례하게 주어지는 신호의 기울기가 변화한다. 이를 그래프로 나타내면 아래와 같이 나오게 된다.

#figure(
  image("images/A-1 discuss.png"),
  caption: "3dB Frequency for Gain"
)

위 그래프와 같이 Gain이 클수록 3dB Frequency가 작아지는 경향성을 보이며, 이론적으로 예측한 식과도 꽤 유사하게 맞음을 확인할 수 있다.

=== Frequency Dependency of the Phase Shift

@A-2 에서 보여준 Anomalous Pahse Shift의 결과는 Frequency가 커질 때 오차가 발생함을 보여준다. 이때의 오차는 Phase Shift를 만드는 과정에서 Phase Shifter 내부에 존재하는 소자 자체의 딜레이보다 Frequency에 인한 속도가 더 빠른 것으로 예상할 수 있다. 이에 frequency가 $10^4$Hz 에서 오차가 발생하기 시작하며, 이는 내부 소자의 delay가 0.1ms 정도가 되는 것으로 예측할 수 있다. 또한, 설정한 Phase Shift에 대해 Delta가 -1의 기울기로 줄어드는 것으로부터 일정한 Shift가 발생하는 것으로 볼 수 있는데, 이때의 Delta는 10 부근의 3#pi 로 나타나 반대 방향으로 뒤집은 신호가 나오는 것으로 생각할 수 있다.

=== DBM Experiment of the Lock-In Amplifier

DBM 실험은 @A-3 에서 수행된 바와 같이 잘 나타난 것을 확인할 수 있으며, 추가적으로 분석할 내용이 크게 있지 않다. 더 상세한 실험을 통해 DBM의 성능을 더욱 정확하게 확인할 수 있을 것으로 예상된다.

=== Gain of the Low Pass Filter

본 실험에서의 Low Pass Filter의 time constant와 $f_{3d B}$의 값을 곱했을 때 모두 거의 1에 가깝게 나타나는 것을 확인할 수 있다. $f_{3d B}$는 얻은 Gain의 값이 물리적인 의미를 잃는 threshold인데, time constant가 신호를 미루어 가면서 적분하는 것을 원리로 가진다는 것을 생각한다면 두 값을 곱한 결과는 거의 일정해야 하는 것을 유추할 수 있다. 

#figure(
  image("images/A-4 discuss.png"),
  caption: "3dB Frequency for Time Constant"
)

위 그래프에서 빨간색 그래프는 $y = 1/x$의 그래프이다. $R^2$의 값이 0.787로 비교적 낮게 나타나는 실험적인 오차가 발생하기는 했지만, 이는 실험적인 오차로 인한 것으로 보인다. 그러나 이론적으로는 두 값의 곱이 1에 가까우며 거의 일정한 것을 확인할 수 있었다.

== Lock-In Detection

=== Spetrum Examination with FFT

Spectrum Examination을 통해 Signal이 어떠한 형태를 가지는지 확인해 볼 수 있었다. 그러나 이보다 더 상세한 분석을 위해서는 해당 신호의 세부적인 형태를 다양한 주파주에 대해서 확인해 보아야 하기에 추가적인 분석을 위해서는 더 많은 데이터가 필요할 것으로 보인다.

=== Signal Detection with Lock-In Amplifier

다양한 Noise를 준 상태에서 Lock-In Amplifier를 이용하여 Noise를 없애 보았다. 위 @B-2 에서와 같이 모든 환경에서 기존의 신호를 그대로 얻어낼 수 있는 것을 확인할 수 있었다. 이는 Noise가 섞인 신호를 Lock-In Amplifier를 통해 처리할 때에 Noise가 섞인 신호를 걸러내어 원하는 신호를 검출해 내는 데에 이용된다는 것을 확인할 수 있다.

=== DC offset stability of the Lock-In Amplifier

DC Offset을 Lock-In Amplifier가 잘 걸러낼 수 있는지를 위한 실험으로 @B-3 의 그래프에서 확인할 수 있듯이 DC Offset이 있는 경우에도 잘 작동하는 것을 확인할 수 있었다. 이는 Lock-In Amplifier가 Noise를 걸러내는 데에 효과적인 장치임을 확인할 수 있다.

== Measurement of the Dipole Moment

마지막으로 이 실험의 실질적인 목표인 자기 쌍극자 모멘트를 측정하는 실험을 수행하였다. 이 실험에서 얻은 결과는 @C 에서 확인할 수 있듯이 자석으로부터 떨어진 거리에 따른 자기장의 세기이고, 이 값을 거리에 대한 함수로 계산하였다. 여기서 피팅을 위해 사용한 함수는 네오디뮴 자석의 크기를 고려하여 계산한 결과이다. 여기서 네오디뮴 자석은 일반적으로 0.75J/T에서 2.0J/T의 자성을 가지는 것이 알려져 있어 @anderson2010structural@herbst1991neodymium@fuerst1993high 본 실험을 통해서 측정한 자성 값과 비교할 수 있다. 각 실험에서 얻은 자성의 값은 각각 1.27, 1.59, 0.76으로 모두 네오디뮴 자석의 잘 알려진 자성의 값의 범위 내에 존재하는 것으로 보인다. 다만 값의 일관성이 충분히 확보되지 않았으며 실험에서의 데이터도 충분히 일관적으로 나타나지 않기 때문에 더 자석에 가까운 위치에서의 자기장까지 측정하여 더 상세한 피팅을 통한 데이터의 분석이 필요할 것으로 보인다.

= Conclusion

이 실험에서는 Lock-In Amplifier의 Calibration을 수행한 뒤 실제로 생성된 신호에 대해 Lock-In Deteocter를 이용한 Signal Detection을 수행하였다. 이렇게 Lock-In Detection을 수행할 수 있게 된 뒤에 Hall Effect를 이용한 홀 소자를 통하여 자기장을 측정할 수 있게되면서 주어진 자석의 자기 쌍극자 모멘트를 계산해 보고 자성을 계산하여 실제 참값과 비교해 볼 수 있게 되었다. 

#bibliography("reference.bib", full:true, style: "american-physics-society")
