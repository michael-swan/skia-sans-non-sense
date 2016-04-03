# Required input variables: OUT_DIR

CC ?= gcc
CXX ?= g++
AR ?= ar

CXXFLAGS += -fPIC

ifeq ($(ENABLE_DEBUG_SKIA),1)
CXXFLAGS += \
	-g \
	-DSK_DEBUG \
	-DGR_DEBUG=1 \
	-DGR_GL_LOG_CALLS=1 \
	-DGR_GL_LOG_CALLS_START=1
else
CXXFLAGS += \
	-O2 \
	-DSK_RELEASE \
	-DGR_RELEASE=1
endif

CXXFLAGS += \
	-DSK_A32_SHIFT=24 -DSK_R32_SHIFT=16 -DSK_G32_SHIFT=8 -DSK_B32_SHIFT=0 \
	-DGR_GL_USE_NEW_SHADER_SOURCE_SIGNATURE=1 \
	-Iinclude/config \
	-Iinclude/core \
	-Iinclude/effects \
	-Iinclude/gpu \
	-Iinclude/images \
	-Iinclude/pathops \
	-Iinclude/pipe \
	-Iinclude/ports \
	-Iinclude/utils \
	-Isrc/core \
	-Isrc/image \
	-Isrc/opts \
	-Isrc/ports \
	-Isrc/sfnt \
	-Isrc/utils \
	-Ithird_party/etc1 \
	-Ithird_party/ktx \
	-iquote src/gpu \
	-I/usr/include/freetype2

USE_CLANG = $(shell $(CXX) --version|grep -c 'clang')
ifeq ($(USE_CLANG),1)
    CXXFLAGS += -Wno-c++11-extensions
endif

SKIA_CORE_CXX_SRC = \
	$(addprefix src/core/,\
		SkAAClip.cpp \
		SkAdvancedTypefaceMetrics.cpp \
		SkAlphaRuns.cpp \
		SkAnnotation.cpp \
		SkBBHFactory.cpp \
		SkBBoxHierarchyRecord.cpp \
		SkBBoxRecord.cpp \
		SkBitmap.cpp \
		SkBitmapDevice.cpp \
		SkBitmapFilter.cpp \
		SkBitmapHeap.cpp \
		SkBitmapProcShader.cpp \
		SkBitmapProcState.cpp \
		SkBitmapProcState_matrixProcs.cpp \
		SkBitmapScaler.cpp \
		SkBitmap_scroll.cpp \
		SkBlitMask_D32.cpp \
		SkBlitRow_D16.cpp \
		SkBlitRow_D32.cpp \
		SkBlitter_A8.cpp \
		SkBlitter_ARGB32.cpp \
		SkBlitter.cpp \
		SkBlitter_RGB16.cpp \
		SkBlitter_Sprite.cpp \
		SkBuffer.cpp \
		SkCanvas.cpp \
		SkChunkAlloc.cpp \
		SkClipStack.cpp \
		SkColor.cpp \
		SkColorFilter.cpp \
		SkColorTable.cpp \
		SkComposeShader.cpp \
		SkConfig8888.cpp \
		SkConvolver.cpp \
		SkCubicClipper.cpp \
		SkData.cpp \
		SkDataTable.cpp \
		SkDebug.cpp \
		SkDeque.cpp \
		SkDevice.cpp \
		SkDeviceLooper.cpp \
		SkDeviceProfile.cpp \
		SkDistanceFieldGen.cpp \
		SkDither.cpp \
		SkDraw.cpp \
		SkDrawLooper.cpp \
		SkEdgeBuilder.cpp \
		SkEdgeClipper.cpp \
		SkEdge.cpp \
		SkError.cpp \
		SkFilterProc.cpp \
		SkFilterShader.cpp \
		SkFlate.cpp \
		SkFlattenable.cpp \
		SkFlattenableSerialization.cpp \
		SkFloatBits.cpp \
		SkFloat.cpp \
		SkFont.cpp \
		SkFontDescriptor.cpp \
		SkFontHost.cpp \
		SkFontStream.cpp \
		SkGeometry.cpp \
		SkGlyphCache.cpp \
		SkGraphics.cpp \
		SkImageFilter.cpp \
		SkImageGenerator.cpp \
		SkImageInfo.cpp \
		SkInstCnt.cpp \
		SkLineClipper.cpp \
		SkLocalMatrixShader.cpp \
		SkMallocPixelRef.cpp \
		SkMask.cpp \
		SkMaskFilter.cpp \
		SkMaskGamma.cpp \
		SkMath.cpp \
		SkMatrixClipStateMgr.cpp \
		SkMatrix.cpp \
		SkMetaData.cpp \
		SkMipMap.cpp \
		SkPackBits.cpp \
		SkPaint.cpp \
		SkPaintOptionsAndroid.cpp \
		SkPaintPriv.cpp \
		SkPath.cpp \
		SkPathEffect.cpp \
		SkPathHeap.cpp \
		SkPathMeasure.cpp \
		SkPathRef.cpp \
		SkPicture.cpp \
		SkPictureFlat.cpp \
		SkPicturePlayback.cpp \
		SkPictureRecord.cpp \
		SkPictureRecorder.cpp \
		SkPictureShader.cpp \
		SkPictureStateTree.cpp \
		SkPixelRef.cpp \
		SkPoint.cpp \
		SkProcSpriteBlitter.cpp \
		SkPtrRecorder.cpp \
		SkQuadClipper.cpp \
		SkQuadTree.cpp \
		SkRasterClip.cpp \
		SkRasterizer.cpp \
		SkReadBuffer.cpp \
		SkRect.cpp \
		SkRefDict.cpp \
		SkRegion.cpp \
		SkRegion_path.cpp \
		SkRRect.cpp \
		SkRTree.cpp \
		SkScalar.cpp \
		SkScaledImageCache.cpp \
		SkScalerContext.cpp \
		SkScan_Antihair.cpp \
		SkScan_AntiPath.cpp \
		SkScan.cpp \
		SkScan_Hairline.cpp \
		SkScan_Path.cpp \
		SkShader.cpp \
		SkSpriteBlitter_ARGB32.cpp \
		SkSpriteBlitter_RGB16.cpp \
		SkStream.cpp \
		SkString.cpp \
		SkStringUtils.cpp \
		SkStroke.cpp \
		SkStrokeRec.cpp \
		SkStrokerPriv.cpp \
		SkTileGrid.cpp \
		SkTLS.cpp \
		SkTSearch.cpp \
		SkTypefaceCache.cpp \
		SkTypeface.cpp \
		SkUnPreMultiply.cpp \
		SkUtilsArm.cpp \
		SkUtils.cpp \
		SkValidatingReadBuffer.cpp \
		SkVertState.cpp \
		SkWriteBuffer.cpp \
		SkWriter32.cpp \
		SkXfermode.cpp \
	)

SKIA_EFFECTS_CXX_SRC = \
	$(addprefix src/effects/,\
		gradients/SkBitmapCache.cpp \
		gradients/SkClampRange.cpp \
		gradients/SkGradientShader.cpp \
		gradients/SkLinearGradient.cpp \
		gradients/SkRadialGradient.cpp \
		gradients/SkSweepGradient.cpp \
		gradients/SkTwoPointConicalGradient.cpp \
		gradients/SkTwoPointConicalGradient_gpu.cpp \
		gradients/SkTwoPointRadialGradient.cpp \
		Sk1DPathEffect.cpp \
		Sk2DPathEffect.cpp \
		SkAlphaThresholdFilter.cpp \
		SkArithmeticMode.cpp \
		SkAvoidXfermode.cpp \
		SkBicubicImageFilter.cpp \
		SkBitmapSource.cpp \
		SkBlurDrawLooper.cpp \
		SkBlurImageFilter.cpp \
		SkBlurMask.cpp \
		SkBlurMaskFilter.cpp \
		SkColorFilterImageFilter.cpp \
		SkColorFilters.cpp \
		SkColorMatrix.cpp \
		SkColorMatrixFilter.cpp \
		SkComposeImageFilter.cpp \
		SkCornerPathEffect.cpp \
		SkDashPathEffect.cpp \
		SkDiscretePathEffect.cpp \
		SkDisplacementMapEffect.cpp \
		SkDropShadowImageFilter.cpp \
		SkEmbossMask.cpp \
		SkEmbossMaskFilter.cpp \
		SkGpuBlurUtils.cpp \
		SkLayerDrawLooper.cpp \
		SkLayerRasterizer.cpp \
		SkLerpXfermode.cpp \
		SkLightingImageFilter.cpp \
		SkLumaColorFilter.cpp \
		SkMagnifierImageFilter.cpp \
		SkMatrixConvolutionImageFilter.cpp \
		SkMatrixImageFilter.cpp \
		SkMergeImageFilter.cpp \
		SkMorphologyImageFilter.cpp \
		SkOffsetImageFilter.cpp \
		SkPaintFlagsDrawFilter.cpp \
		SkPerlinNoiseShader.cpp \
		SkPictureImageFilter.cpp \
		SkPixelXorXfermode.cpp \
		SkPorterDuff.cpp \
		SkRectShaderImageFilter.cpp \
		SkStippleMaskFilter.cpp \
		SkTableColorFilter.cpp \
		SkTableMaskFilter.cpp \
		SkTestImageFilters.cpp \
		SkTileImageFilter.cpp \
		SkTransparentShader.cpp \
		SkXfermodeImageFilter.cpp \
	)

SKIA_GL_CXX_SRC = \
	$(addprefix src/gpu/,\
		effects/GrBezierEffect.cpp \
		effects/GrBicubicEffect.cpp \
		effects/GrConfigConversionEffect.cpp \
		effects/GrConvexPolyEffect.cpp \
		effects/GrConvolutionEffect.cpp \
		effects/GrCustomCoordsTextureEffect.cpp \
		effects/GrDashingEffect.cpp \
		effects/GrDistanceFieldTextureEffect.cpp \
		effects/GrOvalEffect.cpp \
		effects/GrRRectEffect.cpp \
		effects/GrSimpleTextureEffect.cpp \
		effects/GrSingleTextureEffect.cpp \
		effects/GrTextureDomain.cpp \
		effects/GrTextureStripAtlas.cpp \
		gl/debug/GrBufferObj.cpp \
		gl/debug/GrDebugGL.cpp \
		gl/debug/GrFrameBufferObj.cpp \
		gl/debug/GrGLCreateDebugInterface.cpp \
		gl/debug/GrProgramObj.cpp \
		gl/debug/GrShaderObj.cpp \
		gl/debug/GrTextureObj.cpp \
		gl/debug/GrTextureUnitObj.cpp \
		gl/debug/SkDebugGLContext.cpp \
		gl/GrGLAssembleInterface.cpp \
		gl/GrGLBufferImpl.cpp \
		gl/GrGLCaps.cpp \
		gl/GrGLContext.cpp \
		gl/GrGLCreateNullInterface.cpp \
		gl/GrGLDefaultInterface_native.cpp \
		gl/GrGLExtensions.cpp \
		gl/GrGLIndexBuffer.cpp \
		gl/GrGLInterface.cpp \
		gl/GrGLNoOpInterface.cpp \
		gl/GrGLPath.cpp \
		gl/GrGLProgram.cpp \
		gl/GrGLProgramDesc.cpp \
		gl/GrGLProgramEffects.cpp \
		gl/GrGLRenderTarget.cpp \
		gl/GrGLShaderBuilder.cpp \
		gl/GrGLSL.cpp \
		gl/GrGLStencilBuffer.cpp \
		gl/GrGLTexture.cpp \
		gl/GrGLUniformManager.cpp \
		gl/GrGLUtil.cpp \
		gl/GrGLVertexArray.cpp \
		gl/GrGLVertexBuffer.cpp \
		gl/GrGpuGL.cpp \
		gl/GrGpuGL_program.cpp \
		gl/GrGLNameAllocator.cpp \
		gl/SkGLContextHelper.cpp \
		gl/SkNullGLContext.cpp \
		GrAAConvexPathRenderer.cpp \
		GrAAHairLinePathRenderer.cpp \
		GrAARectRenderer.cpp \
		GrAddPathRenderers_default.cpp \
		GrAllocPool.cpp \
		GrAtlas.cpp \
		GrBitmapTextContext.cpp \
		GrBlend.cpp \
		GrBufferAllocPool.cpp \
		GrCacheID.cpp \
		GrClipData.cpp \
		GrClipMaskCache.cpp \
		GrClipMaskManager.cpp \
		GrContext.cpp \
		GrDefaultPathRenderer.cpp \
		GrDistanceFieldTextContext.cpp \
		GrDrawState.cpp \
		GrDrawTarget.cpp \
		GrEffect.cpp \
		GrGpu.cpp \
		GrGpuFactory.cpp \
		GrGpuObject.cpp \
		GrInOrderDrawBuffer.cpp \
		GrLayerCache.cpp \
		GrMemoryPool.cpp \
		GrOvalRenderer.cpp \
		GrPaint.cpp \
		GrPath.cpp \
		GrPathRendererChain.cpp \
		GrPathRenderer.cpp \
		GrPathUtils.cpp \
		GrPictureUtils.cpp \
		GrRectanizer_pow2.cpp \
		GrRectanizer_skyline.cpp \
		GrReducedClip.cpp \
		GrRenderTarget.cpp \
		GrResourceCache.cpp \
		GrSoftwarePathRenderer.cpp \
		GrStencilAndCoverPathRenderer.cpp \
		GrStencilBuffer.cpp \
		GrStencil.cpp \
		GrSurface.cpp \
		GrSWMaskHelper.cpp \
		GrTest.cpp \
		GrTextContext.cpp \
		GrTextStrike.cpp \
		GrTextureAccess.cpp \
		GrTexture.cpp \
		GrTraceMarker.cpp \
		SkGpuDevice.cpp \
		SkGr.cpp \
		SkGrFontScaler.cpp \
		SkGrPixelRef.cpp \
		SkGrTexturePixelRef.cpp \
	)

SKIA_IMAGE_CXX_SRC = \
	$(addprefix src/image/,\
		SkImage_Codec.cpp \
		SkImage.cpp \
		SkImage_Gpu.cpp \
		SkImagePriv.cpp \
		SkImage_Raster.cpp \
		SkSurface.cpp \
		SkSurface_Gpu.cpp \
		SkSurface_Raster.cpp \
	)

SKIA_OPTS_CXX_SRC_X86 = \
	$(addprefix src/opts/,\
		SkBitmapFilter_opts_SSE2.cpp \
		SkBitmapProcState_opts_SSE2.cpp \
		SkBitmapProcState_opts_SSSE3.cpp \
		SkBlitRect_opts_SSE2.cpp \
		SkBlitRow_opts_SSE2.cpp \
		SkBlurImage_opts_SSE2.cpp \
		SkMorphology_opts_SSE2.cpp \
		SkUtils_opts_SSE2.cpp \
		SkXfermode_opts_SSE2.cpp \
		opts_check_x86.cpp \
	)

SKIA_OPTS_CXX_SRC_ARM_NEON = \
	$(addprefix src/opts/,\
		memset.arm.S \
		SkBitmapProcState_opts_arm.cpp \
		SkBlitMask_opts_arm.cpp \
		SkBlitRow_opts_arm.cpp \
		SkBlurImage_opts_arm.cpp \
		SkMorphology_opts_arm.cpp \
		SkUtils_opts_arm.cpp \
		SkXfermode_opts_arm.cpp \
		memset16_neon.S \
		memset32_neon.S \
		SkBitmapProcState_arm_neon.cpp \
		SkBitmapProcState_matrixProcs_neon.cpp \
		SkBlitMask_opts_arm_neon.cpp \
		SkBlitRow_opts_arm_neon.cpp \
		SkBlurImage_opts_neon.cpp \
		SkMorphology_opts_neon.cpp \
		SkXfermode_opts_arm_neon.cpp \
	)

SKIA_OPTS_CXX_SRC_AARCH64 = \
	$(addprefix src/opts/,\
		SkBitmapProcState_opts_arm.cpp \
		SkBlitMask_opts_arm.cpp \
		SkBlitRow_opts_arm.cpp \
		SkBlurImage_opts_arm.cpp \
		SkMorphology_opts_arm.cpp \
		SkUtils_opts_none.cpp \
		SkXfermode_opts_arm.cpp \
		SkBitmapProcState_arm_neon.cpp \
		SkBitmapProcState_matrixProcs_neon.cpp \
		SkBlitMask_opts_arm_neon.cpp \
		SkBlitRow_opts_arm_neon.cpp \
		SkBlurImage_opts_neon.cpp \
		SkMorphology_opts_neon.cpp \
		SkXfermode_opts_arm_neon.cpp \
	)

SKIA_PATHOPS_CXX_SRC = \
	$(addprefix src/pathops/,\
		SkAddIntersections.cpp \
		SkDCubicIntersection.cpp \
		SkDCubicLineIntersection.cpp \
		SkDCubicToQuads.cpp \
		SkDLineIntersection.cpp \
		SkDQuadImplicit.cpp \
		SkDQuadIntersection.cpp \
		SkDQuadLineIntersection.cpp \
		SkIntersections.cpp \
		SkOpAngle.cpp \
		SkOpContour.cpp \
		SkOpEdgeBuilder.cpp \
		SkOpSegment.cpp \
		SkPathOpsBounds.cpp \
		SkPathOpsCommon.cpp \
		SkPathOpsCubic.cpp \
		SkPathOpsDebug.cpp \
		SkPathOpsLine.cpp \
		SkPathOpsOp.cpp \
		SkPathOpsPoint.cpp \
		SkPathOpsQuad.cpp \
		SkPathOpsRect.cpp \
		SkPathOpsSimplify.cpp \
		SkPathOpsTriangle.cpp \
		SkPathOpsTypes.cpp \
		SkPathWriter.cpp \
		SkQuarticRoot.cpp \
		SkReduceOrder.cpp \
	)

SKIA_SFNT_CXX_SRC = \
	$(addprefix src/sfnt/,\
		SkOTTable_name.cpp \
		SkOTUtils.cpp \
	)

SKIA_UTILS_CXX_SRC = \
	$(addprefix src/utils/,\
		SkBase64.cpp \
		SkBitSet.cpp \
		SkBoundaryPatch.cpp \
		SkCamera.cpp \
		SkCanvasStack.cpp \
		SkCanvasStateUtils.cpp \
		SkCondVar.cpp \
		SkCountdown.cpp \
		SkCubicInterval.cpp \
		SkCullPoints.cpp \
		SkDashPath.cpp \
		SkDumpCanvas.cpp \
		SkEventTracer.cpp \
		SkFrontBufferedStream.cpp \
		SkGatherPixelRefsAndRects.cpp \
		SkInterpolator.cpp \
		SkLayer.cpp \
		SkMatrix22.cpp \
		SkMatrix44.cpp \
		SkMD5.cpp \
		SkMeshUtils.cpp \
		SkNinePatch.cpp \
		SkNullCanvas.cpp \
		SkNWayCanvas.cpp \
		SkOSFile.cpp \
		SkParseColor.cpp \
		SkParse.cpp \
		SkParsePath.cpp \
		SkPathUtils.cpp \
		SkPDFRasterizer.cpp \
		SkPictureUtils.cpp \
		SkProxyCanvas.cpp \
		SkRTConf.cpp \
		SkTextureCompressor.cpp \
		SkSHA1.cpp \
	)

SKIA_THIRDPARTY_CXX_SRC = \
	$(addprefix third_party/,\
		etc1/etc1.cpp \
		ktx/ktx.cpp \
	)

ifeq (linux,$(findstring linux,$(TARGET)))
SKIA_GL_CXX_SRC += \
	$(addprefix src/gpu/,\
		gl/unix/GrGLCreateNativeInterface_unix.cpp \
		gl/unix/SkNativeGLContext_unix.cpp \
	)

SKIA_PORTS_CXX_SRC = \
	$(addprefix src/ports/,\
		SkDebug_stdio.cpp \
		SkFontConfigInterface_direct.cpp \
		SkFontHost_FreeType.cpp \
		SkFontHost_FreeType_common.cpp \
		SkFontHost_fontconfig.cpp \
		SkGlobalInitialization_default.cpp \
		SkImageDecoder_empty.cpp \
		SkMemory_malloc.cpp \
		SkOSFile_posix.cpp \
		SkOSFile_stdio.cpp \
		SkTLS_pthread.cpp \
	)

SKIA_FONTS_CXX_SRC = \
	$(addprefix src/fonts/,\
		SkFontMgr_fontconfig.cpp \
	)
endif

SKIA_SRC = \
	$(SKIA_CORE_CXX_SRC) \
	$(SKIA_EFFECTS_CXX_SRC) \
	$(SKIA_FONTS_CXX_SRC) \
	$(SKIA_GL_CXX_SRC) \
	$(SKIA_IMAGE_CXX_SRC) \
	$(SKIA_PATHOPS_CXX_SRC) \
	$(SKIA_PORTS_CXX_SRC) \
	$(SKIA_SFNT_CXX_SRC) \
	$(SKIA_THIRDPARTY_CXX_SRC) \
	$(SKIA_UTILS_CXX_SRC)

ifeq (i686,$(findstring i686,$(TARGET)))
	supports_sse = true
endif
ifeq (x86_64,$(findstring x86_64,$(TARGET)))
	supports_sse = true
endif
ifeq (true,$(supports_sse))
	SKIA_SRC += \
		$(SKIA_OPTS_CXX_SRC_X86)
	PROCESSOR_EXTENSION_CXXFLAGS += \
		-msse2 \
		-mfpmath=sse
endif

ifeq (arm,$(findstring arm,$(TARGET)))
	SKIA_SRC += \
		$(SKIA_OPTS_CXX_SRC_ARM_NEON)
	PROCESSOR_EXTENSION_CXXFLAGS += \
		-mfpu=neon \
		-D__ARM_HAVE_OPTIONAL_NEON_SUPPORT

	# FIXME: Need more advanced detection of FP support
	ifeq (eabihf,$(findstring eabihf,$(TARGET)))
		PROCESSOR_EXTENSION_CXXFLAGS += \
			-mfloat-abi=hard
	else
		PROCESSOR_EXTENSION_CXXFLAGS += \
			-mfloat-abi=softfp
	endif

	ifneq ($(HOST),$(TARGET))
		# FIXME: Assumes armv7 for cross compile
		PROCESSOR_EXTENSION_CXXFLAGS += \
			-march=armv7-a \
			-mthumb
	endif
endif

ifeq (aarch64,$(findstring aarch64,$(TARGET)))
	SKIA_SRC += \
		$(SKIA_OPTS_CXX_SRC_AARCH64)
	PROCESSOR_EXTENSION_CXXFLAGS += \
		-D__ARM_HAVE_NEON
endif

SKIA_OBJS1 = $(patsubst %.cpp,$(OUT_DIR)/%.o,$(SKIA_SRC))
SKIA_OBJS2 = $(patsubst %.c,$(OUT_DIR)/%.o,$(SKIA_OBJS1))
SKIA_OBJS = $(patsubst %.S,$(OUT_DIR)/%.o,$(SKIA_OBJS2))

.PHONY: all
all: $(OUT_DIR)/libskia.a

$(OUT_DIR)/src/ports/SkAtomics_sync.h: src/ports/*.h
	mkdir -p $(OUT_DIR)/src/ports
	cp src/ports/*.h $(OUT_DIR)/src/ports

# opts_check_x86.cpp should not be build with SSE2 instructions enabled, as it is
# used to check for whether the processor supports SSE2 instructions. So we do not
# activate any processor extensions when building the file.
$(OUT_DIR)/%opts_check_x86.o: %opts_check_x86.cpp $(OUT_DIR)/src/ports/SkAtomics_sync.h
	mkdir -p `dirname $@` && $(CXX) -c $(CXXFLAGS) -o $@ $<

# Files that are suffixed in SSE3 require SSE3 to compile, but we cannot rely on
# those extensions for all processors. We only enable those extensions when compiling
# that file. Skia will not call the code if it does not detect SSE3 support
# at runtime.
$(OUT_DIR)/%SSE3.o: %SSE3.cpp $(OUT_DIR)/src/ports/SkAtomics_sync.h
	mkdir -p `dirname $@` && $(CXX) -c $(CXXFLAGS) $(PROCESSOR_EXTENSION_CXXFLAGS) -mssse3 -o $@ $<

$(OUT_DIR)/%.o: %.cpp $(OUT_DIR)/src/ports/SkAtomics_sync.h
	mkdir -p `dirname $@` && $(CXX) -c $(CXXFLAGS) $(PROCESSOR_EXTENSION_CXXFLAGS) -o $@ $<

$(OUT_DIR)/%.o: %.c $(OUT_DIR)/src/ports/SkAtomics_sync.h
	mkdir -p `dirname $@` && $(CC) -c $(CXXFLAGS) $(PROCESSOR_EXTENSION_CXXFLAGS) -o $@ $<

$(OUT_DIR)/%.o: %.S $(OUT_DIR)/src/ports/SkAtomics_sync.h
	mkdir -p `dirname $@` && $(CXX) -c $(CXXFLAGS) $(PROCESSOR_EXTENSION_CXXFLAGS) -o $@ $<

$(OUT_DIR)/libskia.a: $(SKIA_OBJS)
	cp -R include $(OUT_DIR)
	cd $(OUT_DIR) && $(AR) rcs $(subst $(OUT_DIR)/,,$@) $(subst $(OUT_DIR)/,,$(SKIA_OBJS))
