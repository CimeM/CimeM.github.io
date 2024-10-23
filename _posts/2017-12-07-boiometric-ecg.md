---
layout: post
current: post
cover:  assets/images/cardio.png
navigation: True
title: ECG signal biometry
date: 2017-12-07 10:00:00
tags: [Biometry]
class: post-template
subclass: 'post data ecg'
author: martin
published: true
---

Biometrics technology is a way to apply mathematics to the nature, by using unique patterns of physiological and behavioural characteristics. We use biometrics every day to solve our security needs. We use it to unlock our computers, pay online and access our workplace by using our fingerprints, faces, and other biometrical features. Security has always been a prime concern of societies. Identity theft, ID manipulation and other cyber crimes are challenges that need a potent solution. To ensure security, biometrics is applied as a layer that provides for personal, governmental and even forensic applications. We use our fingerprints to unlock our phones. Is it possible for us to use heart ECG signals to do the same? We are own more technology than ever before, it will not be long since our wearables will be able to recognise us based on our heart.
Measuring ones heart behaviour and using it as an identification tool is a challenge. Mainly because producing reliable measurements is not as quick as taking a hi-res photo of retinas or scanning your fingerprints. Regular ECG measurements, take up to 10 minutes because our body needs to be stabilised in order to produce reliable measurements. Not to mention that the beating pattern changes on monthly basis and could change in a years time. The template would have to be updated periodically.
The heart is a muscle, at every beat, the heart is depolarized to trigger its contraction. By depolarization, muscles tell other when to fire. Depolarization activity is carried through the body and can be picked up on the skin as well. ECG is usually measured with up to then electrodes attached to the body. One for each limb and remaining 6 for the chest area. Sensitive amplifiers and filters pick up on the signal and filter out the noise. Thinking that our smartwatches would be able to measure our heart signals percisely would be an optimistic idea. Our oxy-meters are limited and do not satisfy the need for precise measurements that could later be used for identification.
I didn’t have the luxury or the time to gain ECG measurements from several people. Luckily, there are databases of ECG signals ready for research and education purposes online. MIT’s Lab for Computational Physiology provides just what I needed. A corpus of 90 samples of different individuals. Their ECG signals were measured in the course of 6 months.
Next step is to focus on the ECG signal features. For that, we need to deconstruct the wave structure:

The ECG signal was deconstructed by its signature waves:
P wave — is a small deflection wave that represents atrial depolarization.
PR — interval is the time between the first deflection of the P wave and the first deflection of the QRS complex.
QRS wave complex — consists of three waves representing ventricular depolarization.
 Q waves represent depolarization of interventricular septum. They can be picked up by breathing or an old myocardial infarction.
 R — reflects depolarization of main mass of the ventricles — largest valve
 S — depolarization of the ventricles
 T — ventricular repolarization — aka recovery wave

![](assets/images/cardio.png")


Hand-marked marcations and ECG signals were use to train the template. Features consist of the combination of time intervals, their amplitude and angles.
Linear discriminant analysis (LDA) was used to produce results that were later presented as False Acceptance rate and False Rejection Rate.
FAR is the measure of the likelihood that the biometric security system will incorrectly accept an access attempt by an unauthorised user. FAR is typically stated as the ratio of the number of false acceptances divided by the number of identification attempts.
FRR is the measure of the likelihood that the biometric system will incorrectly reject an access attempt by an authorised user. A system’s FRR typically is stated as the ratio of the number of false recognitions divided by the number of identification attempts.
FAR and FRR equilibrium usually displays the meeting point of both graphs, and thus displays the comparison objectively.

![](assets/images/ecg_biometric_success.png)



From the graph, we can see that the error rate is 14% where the graphs meet. That tells us, that falsely identifying the imposter is low.
The biometric system can run in two different modes: identification and verification.
Identification is trying to recognise a person from his or her biometric data. The system is trained with the patterns of several persons. For every person, a template is calculated (training). A pattern being matched is being compared to every available template. The result is the score/distance between the template and a pattern. Lower the distance, better the match! To prevent imposters from accessing, the score/distance must reach a certain threshold. If the score doesn’t reach the threshold, the pattern is rejected.
Verification is done a bit differently. Persons, biometric data is taken beforehand and saved. Once the person tries to verify, the algorithm compares entered biometric pattern only to his/hers template in the pool. Verification is successful when the difference between the pattern and template is small.
When comparing weights of patterns to the weights of templates we always get results that tell us how similar the pattern and templates are. Intruders would theoretically have less similar scores than clients.
Thresholding the results would provide a clear line between rejected scores and the ones that get accepted. But there are still some irregularities. Imposters could have better scores than some clients. That would lead to False Acceptance. And some clients could have bad results and that would lead to False Rejection. If we define the threshold somewhere in between those two levels both false acceptance and false recognition could occur.

Reference:
* Cardiology Explained Remedica Explained Series Euan A Ashley and Josef Niebauer
* Heart Biometrics: Theory, Methods and Applications, Foteini Agrafioti, Jiexin Gao and Dimitrios Hatzinakos
* Biometrics Method of Human Identification using Electrocardiogram Yogendra Narain Singh, P. Gupta India
