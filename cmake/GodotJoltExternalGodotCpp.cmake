include_guard()

include(GodotJoltExternalLibrary)

set(configurations
	Debug
	Distribution
	EditorDebug
	EditorDistribution
)

set(is_msvc_like $<BOOL:${MSVC}>)

set(editor_definitions
	DEBUG_ENABLED
	DEBUG_METHODS_ENABLED
	TOOLS_ENABLED
)

GodotJoltExternalLibrary_Add(godot-cpp "${configurations}"
	GIT_REPOSITORY https://github.com/godot-jolt/godot-cpp.git
	GIT_COMMIT a1ae7959da3ce52951b3fed37a018960d03eb785
	LANGUAGE CXX
	OUTPUT_NAME godot-cpp
	INCLUDE_DIRECTORIES
		<SOURCE_DIR>/gdextension
		<SOURCE_DIR>/include
		<BINARY_DIR>/gen/include
	COMPILE_DEFINITIONS
		$<${is_msvc_like}:TYPED_METHOD_BIND>
	COMPILE_DEFINITIONS_EDITORDEBUG
		${editor_definitions}
	COMPILE_DEFINITIONS_EDITORDEVELOPMENT
		${editor_definitions}
	COMPILE_DEFINITIONS_EDITORDISTRIBUTION
		${editor_definitions}
	CMAKE_CACHE_ARGS
		-DCMAKE_UNITY_BUILD=TRUE
		-DCMAKE_UNITY_BUILD_BATCH_SIZE=32
		-DCMAKE_INTERPROCEDURAL_OPTIMIZATION_DISTRIBUTION=${GDJOLT_INTERPROCEDURAL_OPTIMIZATION}
		-DCMAKE_INTERPROCEDURAL_OPTIMIZATION_EDITORDISTRIBUTION=${GDJOLT_INTERPROCEDURAL_OPTIMIZATION}
		-DGDCPP_X86_INSTRUCTION_SET=${GDJOLT_X86_INSTRUCTION_SET}
	LIBRARY_CONFIG_DEBUG Debug
	LIBRARY_CONFIG_DEVELOPMENT Distribution
	LIBRARY_CONFIG_DISTRIBUTION Distribution
	LIBRARY_CONFIG_EDITORDEBUG EditorDebug
	LIBRARY_CONFIG_EDITORDEVELOPMENT EditorDistribution
	LIBRARY_CONFIG_EDITORDISTRIBUTION EditorDistribution
)
