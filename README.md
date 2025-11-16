# Image-Watermarking-for-Copyright-Protection
Project Description:

Summary – A hybrid visible–invisible watermarking system using DWT, SVD, and spread-spectrum techniques to embed a colored logo and a robust hidden watermark into images. The project improves ownership protection, resists attacks like noise, compression, and cropping, and enables reliable watermark extraction.

Course concepts used –
1. Digital Image Processing (RGB, YCbCr)
2. DWT (LL/LH/HL/HH bands)
3. Image Quality Metrics (MSE, PSNR, NCC)

Additional concepts used –
1. SVD-based embedding
2. Spread Spectrum (PN noise)
3. Tiled watermarking for cropping resistance

Dataset –

Novelty –
1. Hybrid DWT + SVD + Spread Spectrum invisible watermarking
2. Dual watermarking (visible + invisible)
3. Cropping-resistant tiled embedding strategy

Contributors:
1. H P Nanditha (PES1UG23EC113)
2. Hemanth BS (PES1UG23EC123)
3. Swetha Krishnakumar (PES1UG23EC318)

Steps:
1. Clone Repository git clone https://github.com/DIP-2025-MINI-PROJECT/Image-Watermarking-for-Copyright-Protection.git

Outputs:
1. Watermarked image with visible and invisible logos.
2. Attacked images (noise, compression, cropping).
3. Extracted invisible watermark with MSE, PSNR, NCC metrics.

Output Screenshots: 

<img width="830" height="200" alt="image" src="https://github.com/user-attachments/assets/0cb9aec9-09e0-468b-85c4-16aa58bc07f8" />
<img width="798" height="188" alt="image" src="https://github.com/user-attachments/assets/40fa8724-cb7b-450a-95ba-59ca019e18e9" />
<img width="863" height="582" alt="image" src="https://github.com/user-attachments/assets/dd99abab-64f5-43f4-859a-444a4042457e" />



References:
1. [1]A. Furqan and M. Kumar, "Study and Analysis of Robust DWT-SVD Domain Based Digital Image Watermarking Technique Using MATLAB," 2015 IEEE International Conference on Computational Intelligence & Communication Technology, Ghaziabad, India, 2015, pp. 638-644, doi: 10.1109/CICT.2015.74.
2. [2]C. -C. Lai and C. -C. Tsai, "Digital Image Watermarking Using Discrete Wavelet Transform and Singular Value Decomposition," in IEEE Transactions on Instrumentation and Measurement, vol. 59, no. 11, pp. 3060-3063, Nov. 2010, doi: 10.1109/TIM.2010.2066770.
3. [3]Ganic, Emir & Ahmet, Meryem. (2004). Robust DWT-SVD domain image watermarking: embedding data in all frequencies. 166-174. 10.1145/1022431.1022461.
4. [4]H. Tao, C. Li, J. Mohamad Zain, and A. N. Abdalla, “Robust image watermarking theories and techniques: A review,” Journal of Applied Research and Technology, vol. 12, no. 1, pp. 122–138, 2014


Limitations and Future Work:

Limitations:
1. Strong embedding reduces image PSNR
2. Large cropping can still remove watermark
3. PN extraction requires correct seed

Future Work:
1. Add DWT + DCT + SVD triple-domain method
2. Blind extraction model
3. Include ECC for error-resilient recovery
4. Explore deep-learning watermarking
