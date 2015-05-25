/* Include files */

#include <stddef.h>
#include "blas.h"
#include "viptraffic_win_sfun.h"
#include "c2_viptraffic_win.h"
#include "mwmathutil.h"
#define CHARTINSTANCE_CHARTNUMBER      (chartInstance->chartNumber)
#define CHARTINSTANCE_INSTANCENUMBER   (chartInstance->instanceNumber)
#include "viptraffic_win_sfun_debug_macros.h"
#define _SF_MEX_LISTEN_FOR_CTRL_C(S)   sf_mex_listen_for_ctrl_c(sfGlobalDebugInstanceStruct,S);

/* Type Definitions */

/* Named Constants */
#define CALL_EVENT                     (-1)
#define c2_b_line_row                  (22.0)

/* Variable Declarations */

/* Variable Definitions */
static real_T _sfTime_;
static const char * c2_debug_family_names[7] = { "dim", "repVector", "line_row",
  "nargin", "nargout", "u", "y" };

/* Function Declarations */
static void initialize_c2_viptraffic_win(SFc2_viptraffic_winInstanceStruct
  *chartInstance);
static void initialize_params_c2_viptraffic_win
  (SFc2_viptraffic_winInstanceStruct *chartInstance);
static void enable_c2_viptraffic_win(SFc2_viptraffic_winInstanceStruct
  *chartInstance);
static void disable_c2_viptraffic_win(SFc2_viptraffic_winInstanceStruct
  *chartInstance);
static void c2_update_debugger_state_c2_viptraffic_win
  (SFc2_viptraffic_winInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c2_viptraffic_win
  (SFc2_viptraffic_winInstanceStruct *chartInstance);
static void set_sim_state_c2_viptraffic_win(SFc2_viptraffic_winInstanceStruct
  *chartInstance, const mxArray *c2_st);
static void finalize_c2_viptraffic_win(SFc2_viptraffic_winInstanceStruct
  *chartInstance);
static void sf_gateway_c2_viptraffic_win(SFc2_viptraffic_winInstanceStruct
  *chartInstance);
static void mdl_start_c2_viptraffic_win(SFc2_viptraffic_winInstanceStruct
  *chartInstance);
static void initSimStructsc2_viptraffic_win(SFc2_viptraffic_winInstanceStruct
  *chartInstance);
static void init_script_number_translation(uint32_T c2_machineNumber, uint32_T
  c2_chartNumber, uint32_T c2_instanceNumber);
static const mxArray *c2_sf_marshallOut(void *chartInstanceVoid, int32_T
  c2_inData_data[], int32_T c2_inData_sizes[2]);
static void c2_emlrt_marshallIn(SFc2_viptraffic_winInstanceStruct *chartInstance,
  const mxArray *c2_y, const char_T *c2_identifier, int32_T c2_b_y_data[],
  int32_T c2_b_y_sizes[2]);
static void c2_b_emlrt_marshallIn(SFc2_viptraffic_winInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId,
  int32_T c2_b_y_data[], int32_T c2_b_y_sizes[2]);
static void c2_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, int32_T c2_outData_data[],
  int32_T c2_outData_sizes[2]);
static const mxArray *c2_b_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static real_T c2_c_emlrt_marshallIn(SFc2_viptraffic_winInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId);
static void c2_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static const mxArray *c2_c_sf_marshallOut(void *chartInstanceVoid, real_T
  c2_inData_data[], int32_T c2_inData_sizes[2]);
static void c2_d_emlrt_marshallIn(SFc2_viptraffic_winInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId,
  real_T c2_b_y_data[], int32_T c2_b_y_sizes[2]);
static void c2_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, real_T c2_outData_data[], int32_T
  c2_outData_sizes[2]);
static const mxArray *c2_d_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static void c2_e_emlrt_marshallIn(SFc2_viptraffic_winInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId,
  real_T c2_y[2]);
static void c2_d_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static void c2_repmat(SFc2_viptraffic_winInstanceStruct *chartInstance, real_T
                      c2_varargin_1, real_T c2_b_data[], int32_T c2_b_sizes[2]);
static void c2_eml_assert_valid_size_arg(SFc2_viptraffic_winInstanceStruct
  *chartInstance, real_T c2_varargin_1);
static boolean_T c2_isinbounds(SFc2_viptraffic_winInstanceStruct *chartInstance,
  real_T c2_arg);
static void c2_eml_switch_helper(SFc2_viptraffic_winInstanceStruct
  *chartInstance);
static const mxArray *c2_e_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static int32_T c2_f_emlrt_marshallIn(SFc2_viptraffic_winInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId);
static void c2_e_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static uint8_T c2_g_emlrt_marshallIn(SFc2_viptraffic_winInstanceStruct
  *chartInstance, const mxArray *c2_b_is_active_c2_viptraffic_win, const char_T *
  c2_identifier);
static uint8_T c2_h_emlrt_marshallIn(SFc2_viptraffic_winInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId);
static void init_dsm_address_info(SFc2_viptraffic_winInstanceStruct
  *chartInstance);
static void init_simulink_io_address(SFc2_viptraffic_winInstanceStruct
  *chartInstance);

/* Function Definitions */
static void initialize_c2_viptraffic_win(SFc2_viptraffic_winInstanceStruct
  *chartInstance)
{
  chartInstance->c2_sfEvent = CALL_EVENT;
  _sfTime_ = sf_get_time(chartInstance->S);
  chartInstance->c2_is_active_c2_viptraffic_win = 0U;
}

static void initialize_params_c2_viptraffic_win
  (SFc2_viptraffic_winInstanceStruct *chartInstance)
{
  real_T c2_d0;
  sf_mex_import_named("line_row", sf_mex_get_sfun_param(chartInstance->S, 0, 0),
                      &c2_d0, 0, 0, 0U, 0, 0U, 0);
  chartInstance->c2_line_row = c2_d0;
}

static void enable_c2_viptraffic_win(SFc2_viptraffic_winInstanceStruct
  *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void disable_c2_viptraffic_win(SFc2_viptraffic_winInstanceStruct
  *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void c2_update_debugger_state_c2_viptraffic_win
  (SFc2_viptraffic_winInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static const mxArray *get_sim_state_c2_viptraffic_win
  (SFc2_viptraffic_winInstanceStruct *chartInstance)
{
  const mxArray *c2_st;
  const mxArray *c2_y = NULL;
  int32_T c2_b_u_sizes[2];
  int32_T c2_u;
  int32_T c2_b_u;
  int32_T c2_loop_ub;
  int32_T c2_i0;
  int32_T c2_b_u_data[320];
  const mxArray *c2_b_y = NULL;
  uint8_T c2_hoistedGlobal;
  uint8_T c2_c_u;
  const mxArray *c2_c_y = NULL;
  c2_st = NULL;
  c2_st = NULL;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_createcellmatrix(2, 1), false);
  c2_b_u_sizes[0] = (*chartInstance->c2_y_sizes)[0];
  c2_b_u_sizes[1] = (*chartInstance->c2_y_sizes)[1];
  c2_u = c2_b_u_sizes[0];
  c2_b_u = c2_b_u_sizes[1];
  c2_loop_ub = (*chartInstance->c2_y_sizes)[0] * (*chartInstance->c2_y_sizes)[1]
    - 1;
  for (c2_i0 = 0; c2_i0 <= c2_loop_ub; c2_i0++) {
    c2_b_u_data[c2_i0] = (*chartInstance->c2_y_data)[c2_i0];
  }

  c2_b_y = NULL;
  sf_mex_assign(&c2_b_y, sf_mex_create("y", c2_b_u_data, 6, 0U, 1U, 0U, 2,
    c2_b_u_sizes[0], c2_b_u_sizes[1]), false);
  sf_mex_setcell(c2_y, 0, c2_b_y);
  c2_hoistedGlobal = chartInstance->c2_is_active_c2_viptraffic_win;
  c2_c_u = c2_hoistedGlobal;
  c2_c_y = NULL;
  sf_mex_assign(&c2_c_y, sf_mex_create("y", &c2_c_u, 3, 0U, 0U, 0U, 0), false);
  sf_mex_setcell(c2_y, 1, c2_c_y);
  sf_mex_assign(&c2_st, c2_y, false);
  return c2_st;
}

static void set_sim_state_c2_viptraffic_win(SFc2_viptraffic_winInstanceStruct
  *chartInstance, const mxArray *c2_st)
{
  const mxArray *c2_u;
  int32_T c2_tmp_sizes[2];
  int32_T c2_tmp_data[320];
  int32_T c2_i1;
  int32_T c2_i2;
  int32_T c2_loop_ub;
  int32_T c2_i3;
  chartInstance->c2_doneDoubleBufferReInit = true;
  c2_u = sf_mex_dup(c2_st);
  c2_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c2_u, 0)), "y",
                      c2_tmp_data, c2_tmp_sizes);
  ssSetCurrentOutputPortDimensions_wrapper(chartInstance->S, 1, 0, c2_tmp_sizes
    [0]);
  ssSetCurrentOutputPortDimensions_wrapper(chartInstance->S, 1, 1, c2_tmp_sizes
    [1]);
  c2_i1 = (*chartInstance->c2_y_sizes)[0];
  c2_i2 = (*chartInstance->c2_y_sizes)[1];
  c2_loop_ub = c2_tmp_sizes[0] * c2_tmp_sizes[1] - 1;
  for (c2_i3 = 0; c2_i3 <= c2_loop_ub; c2_i3++) {
    (*chartInstance->c2_y_data)[c2_i3] = c2_tmp_data[c2_i3];
  }

  chartInstance->c2_is_active_c2_viptraffic_win = c2_g_emlrt_marshallIn
    (chartInstance, sf_mex_dup(sf_mex_getcell(c2_u, 1)),
     "is_active_c2_viptraffic_win");
  sf_mex_destroy(&c2_u);
  c2_update_debugger_state_c2_viptraffic_win(chartInstance);
  sf_mex_destroy(&c2_st);
}

static void finalize_c2_viptraffic_win(SFc2_viptraffic_winInstanceStruct
  *chartInstance)
{
  (void)chartInstance;
}

static void sf_gateway_c2_viptraffic_win(SFc2_viptraffic_winInstanceStruct
  *chartInstance)
{
  int32_T c2_loop_ub;
  int32_T c2_i4;
  int32_T c2_b_u_sizes[2];
  int32_T c2_u;
  int32_T c2_b_u;
  int32_T c2_b_loop_ub;
  int32_T c2_i5;
  int32_T c2_b_u_data[320];
  uint32_T c2_debug_family_var_map[7];
  real_T c2_dim[2];
  int32_T c2_repVector_sizes[2];
  real_T c2_repVector_data[320];
  real_T c2_c_line_row;
  real_T c2_nargin = 2.0;
  real_T c2_nargout = 1.0;
  int32_T c2_b_y_sizes[2];
  int32_T c2_b_y_data[320];
  int32_T c2_i6;
  int32_T c2_i7;
  real_T c2_dv0[2];
  int32_T c2_iv0[2];
  int32_T c2_iv1[2];
  int32_T c2_repVector;
  int32_T c2_b_repVector;
  int32_T c2_c_loop_ub;
  int32_T c2_i8;
  int32_T c2_tmp_sizes[2];
  real_T c2_tmp_data[320];
  int32_T c2_c_repVector;
  int32_T c2_d_repVector;
  int32_T c2_d_loop_ub;
  int32_T c2_i9;
  int32_T c2_b_repVector_sizes[2];
  int32_T c2_e_repVector;
  int32_T c2_f_repVector;
  int32_T c2_e_loop_ub;
  int32_T c2_i10;
  real_T c2_d1;
  int32_T c2_i11;
  int32_T c2_b_repVector_data[320];
  int32_T c2_i12;
  int32_T c2_c_u[2];
  int32_T c2_i13;
  int32_T c2_g_repVector[2];
  int32_T c2_y;
  int32_T c2_b_y;
  int32_T c2_f_loop_ub;
  int32_T c2_i14;
  real_T c2_d2;
  int32_T c2_i15;
  int64_T c2_i16;
  int32_T c2_i17;
  int32_T c2_i18;
  int32_T c2_g_loop_ub;
  int32_T c2_i19;
  int32_T c2_h_loop_ub;
  int32_T c2_i20;
  _SFD_SYMBOL_SCOPE_PUSH(0U, 0U);
  _sfTime_ = sf_get_time(chartInstance->S);
  _SFD_CC_CALL(CHART_ENTER_SFUNCTION_TAG, 0U, chartInstance->c2_sfEvent);
  c2_loop_ub = (*chartInstance->c2_u_sizes)[0] * (*chartInstance->c2_u_sizes)[1]
    - 1;
  for (c2_i4 = 0; c2_i4 <= c2_loop_ub; c2_i4++) {
    _SFD_DATA_RANGE_CHECK_MAX((real_T)(*chartInstance->c2_u_data)[c2_i4], 0U,
      320.0);
  }

  chartInstance->c2_sfEvent = CALL_EVENT;
  _SFD_CC_CALL(CHART_ENTER_DURING_FUNCTION_TAG, 0U, chartInstance->c2_sfEvent);
  c2_b_u_sizes[0] = (*chartInstance->c2_u_sizes)[0];
  c2_b_u_sizes[1] = (*chartInstance->c2_u_sizes)[1];
  c2_u = c2_b_u_sizes[0];
  c2_b_u = c2_b_u_sizes[1];
  c2_b_loop_ub = (*chartInstance->c2_u_sizes)[0] * (*chartInstance->c2_u_sizes)
    [1] - 1;
  for (c2_i5 = 0; c2_i5 <= c2_b_loop_ub; c2_i5++) {
    c2_b_u_data[c2_i5] = (*chartInstance->c2_u_data)[c2_i5];
  }

  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 7U, 7U, c2_debug_family_names,
    c2_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c2_dim, 0U, c2_d_sf_marshallOut,
    c2_d_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_DYN_IMPORTABLE(c2_repVector_data, (const int32_T *)
    &c2_repVector_sizes, NULL, 0, 1, (void *)c2_c_sf_marshallOut, (void *)
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_c_line_row, 2U, c2_b_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargin, 3U, c2_b_sf_marshallOut,
    c2_b_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargout, 4U, c2_b_sf_marshallOut,
    c2_b_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_DYN(c2_b_u_data, (const int32_T *)&c2_b_u_sizes,
    NULL, 1, 5, (void *)c2_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_DYN_IMPORTABLE(c2_b_y_data, (const int32_T *)
    &c2_b_y_sizes, NULL, 0, 6, (void *)c2_sf_marshallOut, (void *)
    c2_sf_marshallIn);
  c2_c_line_row = 22.0;
  CV_EML_FCN(0, 0);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 3);
  for (c2_i6 = 0; c2_i6 < 2; c2_i6++) {
    c2_dim[c2_i6] = (real_T)c2_b_u_sizes[c2_i6];
  }

  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 4);
  for (c2_i7 = 0; c2_i7 < 2; c2_i7++) {
    c2_dv0[c2_i7] = c2_dim[c2_i7];
  }

  c2_iv0[0] = (int32_T)c2_dv0[0];
  c2_iv0[1] = (int32_T)c2_dv0[1];
  c2_repVector_sizes[0] = c2_iv0[0];
  c2_iv1[0] = (int32_T)c2_dv0[0];
  c2_iv1[1] = (int32_T)c2_dv0[1];
  c2_repVector_sizes[1] = c2_iv1[1];
  c2_repVector = c2_repVector_sizes[0];
  c2_b_repVector = c2_repVector_sizes[1];
  c2_c_loop_ub = (int32_T)c2_dv0[0] * (int32_T)c2_dv0[1] - 1;
  for (c2_i8 = 0; c2_i8 <= c2_c_loop_ub; c2_i8++) {
    c2_repVector_data[c2_i8] = 0.0;
  }

  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 5);
  c2_repmat(chartInstance, c2_dim[0], c2_tmp_data, c2_tmp_sizes);
  c2_repVector_sizes[0] = c2_tmp_sizes[0];
  c2_repVector_sizes[1] = 4;
  c2_c_repVector = c2_repVector_sizes[0];
  c2_d_repVector = c2_repVector_sizes[1];
  c2_d_loop_ub = c2_tmp_sizes[0] * c2_tmp_sizes[1] - 1;
  for (c2_i9 = 0; c2_i9 <= c2_d_loop_ub; c2_i9++) {
    c2_repVector_data[c2_i9] = c2_tmp_data[c2_i9];
  }

  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 7);
  c2_b_repVector_sizes[0] = c2_repVector_sizes[0];
  c2_b_repVector_sizes[1] = c2_repVector_sizes[1];
  c2_e_repVector = c2_b_repVector_sizes[0];
  c2_f_repVector = c2_b_repVector_sizes[1];
  c2_e_loop_ub = c2_repVector_sizes[0] * c2_repVector_sizes[1] - 1;
  for (c2_i10 = 0; c2_i10 <= c2_e_loop_ub; c2_i10++) {
    c2_d1 = muDoubleScalarRound(c2_repVector_data[c2_i10]);
    if (c2_d1 < 2.147483648E+9) {
      if (CV_SATURATION_EVAL(4, 0, 1, 1, c2_d1 >= -2.147483648E+9)) {
        c2_i11 = (int32_T)c2_d1;
      } else {
        c2_i11 = MIN_int32_T;
      }
    } else if (CV_SATURATION_EVAL(4, 0, 1, 0, c2_d1 >= 2.147483648E+9)) {
      c2_i11 = MAX_int32_T;
    } else {
      c2_i11 = 0;
    }

    c2_b_repVector_data[c2_i10] = c2_i11;
  }

  for (c2_i12 = 0; c2_i12 < 2; c2_i12++) {
    c2_c_u[c2_i12] = c2_b_u_sizes[c2_i12];
  }

  for (c2_i13 = 0; c2_i13 < 2; c2_i13++) {
    c2_g_repVector[c2_i13] = c2_b_repVector_sizes[c2_i13];
  }

  _SFD_SIZE_EQ_CHECK_ND(c2_c_u, c2_g_repVector, 2);
  _SFD_DIM_SIZE_GEQ_CHECK(80, c2_b_u_sizes[0], 1);
  _SFD_DIM_SIZE_GEQ_CHECK(4, c2_b_u_sizes[1], 2);
  c2_b_y_sizes[0] = c2_b_u_sizes[0];
  c2_b_y_sizes[1] = c2_b_u_sizes[1];
  c2_y = c2_b_y_sizes[0];
  c2_b_y = c2_b_y_sizes[1];
  c2_f_loop_ub = c2_b_u_sizes[0] * c2_b_u_sizes[1] - 1;
  for (c2_i14 = 0; c2_i14 <= c2_f_loop_ub; c2_i14++) {
    c2_d2 = muDoubleScalarRound(c2_repVector_data[c2_i14]);
    if (c2_d2 < 2.147483648E+9) {
      if (CV_SATURATION_EVAL(4, 0, 1, 1, c2_d2 >= -2.147483648E+9)) {
        c2_i15 = (int32_T)c2_d2;
      } else {
        c2_i15 = MIN_int32_T;
      }
    } else if (CV_SATURATION_EVAL(4, 0, 1, 0, c2_d2 >= 2.147483648E+9)) {
      c2_i15 = MAX_int32_T;
    } else {
      c2_i15 = 0;
    }

    c2_i16 = (int64_T)c2_b_u_data[c2_i14] + (int64_T)c2_i15;
    if (c2_i16 > 2147483647LL) {
      CV_SATURATION_EVAL(4, 0, 0, 0, 1);
      c2_i16 = 2147483647LL;
    } else {
      if (CV_SATURATION_EVAL(4, 0, 0, 0, c2_i16 < -2147483648LL)) {
        c2_i16 = -2147483648LL;
      }
    }

    c2_b_y_data[c2_i14] = (int32_T)c2_i16;
  }

  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, -7);
  _SFD_SYMBOL_SCOPE_POP();
  ssSetCurrentOutputPortDimensions_wrapper(chartInstance->S, 1, 0, c2_b_y_sizes
    [0]);
  ssSetCurrentOutputPortDimensions_wrapper(chartInstance->S, 1, 1, c2_b_y_sizes
    [1]);
  c2_i17 = (*chartInstance->c2_y_sizes)[0];
  c2_i18 = (*chartInstance->c2_y_sizes)[1];
  c2_g_loop_ub = c2_b_y_sizes[0] * c2_b_y_sizes[1] - 1;
  for (c2_i19 = 0; c2_i19 <= c2_g_loop_ub; c2_i19++) {
    (*chartInstance->c2_y_data)[c2_i19] = c2_b_y_data[c2_i19];
  }

  _SFD_CC_CALL(EXIT_OUT_OF_FUNCTION_TAG, 0U, chartInstance->c2_sfEvent);
  _SFD_SYMBOL_SCOPE_POP();
  _SFD_CHECK_FOR_STATE_INCONSISTENCY(_viptraffic_winMachineNumber_,
    chartInstance->chartNumber, chartInstance->instanceNumber);
  c2_h_loop_ub = (*chartInstance->c2_y_sizes)[0] * (*chartInstance->c2_y_sizes)
    [1] - 1;
  for (c2_i20 = 0; c2_i20 <= c2_h_loop_ub; c2_i20++) {
    _SFD_DATA_RANGE_CHECK_MAX((real_T)(*chartInstance->c2_y_data)[c2_i20], 1U,
      320.0);
  }

  _SFD_DATA_RANGE_CHECK(chartInstance->c2_line_row, 2U);
}

static void mdl_start_c2_viptraffic_win(SFc2_viptraffic_winInstanceStruct
  *chartInstance)
{
  (void)chartInstance;
}

static void initSimStructsc2_viptraffic_win(SFc2_viptraffic_winInstanceStruct
  *chartInstance)
{
  (void)chartInstance;
}

static void init_script_number_translation(uint32_T c2_machineNumber, uint32_T
  c2_chartNumber, uint32_T c2_instanceNumber)
{
  (void)c2_machineNumber;
  (void)c2_chartNumber;
  (void)c2_instanceNumber;
}

static const mxArray *c2_sf_marshallOut(void *chartInstanceVoid, int32_T
  c2_inData_data[], int32_T c2_inData_sizes[2])
{
  const mxArray *c2_mxArrayOutData = NULL;
  int32_T c2_b_u_sizes[2];
  int32_T c2_u;
  int32_T c2_b_u;
  int32_T c2_inData;
  int32_T c2_b_inData;
  int32_T c2_b_inData_sizes;
  int32_T c2_loop_ub;
  int32_T c2_i21;
  int32_T c2_b_inData_data[320];
  int32_T c2_b_loop_ub;
  int32_T c2_i22;
  int32_T c2_b_u_data[320];
  const mxArray *c2_y = NULL;
  SFc2_viptraffic_winInstanceStruct *chartInstance;
  chartInstance = (SFc2_viptraffic_winInstanceStruct *)chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_b_u_sizes[0] = c2_inData_sizes[0];
  c2_b_u_sizes[1] = c2_inData_sizes[1];
  c2_u = c2_b_u_sizes[0];
  c2_b_u = c2_b_u_sizes[1];
  c2_inData = c2_inData_sizes[0];
  c2_b_inData = c2_inData_sizes[1];
  c2_b_inData_sizes = c2_inData * c2_b_inData;
  c2_loop_ub = c2_inData * c2_b_inData - 1;
  for (c2_i21 = 0; c2_i21 <= c2_loop_ub; c2_i21++) {
    c2_b_inData_data[c2_i21] = c2_inData_data[c2_i21];
  }

  c2_b_loop_ub = c2_b_inData_sizes - 1;
  for (c2_i22 = 0; c2_i22 <= c2_b_loop_ub; c2_i22++) {
    c2_b_u_data[c2_i22] = c2_b_inData_data[c2_i22];
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_b_u_data, 6, 0U, 1U, 0U, 2,
    c2_b_u_sizes[0], c2_b_u_sizes[1]), false);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, false);
  return c2_mxArrayOutData;
}

static void c2_emlrt_marshallIn(SFc2_viptraffic_winInstanceStruct *chartInstance,
  const mxArray *c2_y, const char_T *c2_identifier, int32_T c2_b_y_data[],
  int32_T c2_b_y_sizes[2])
{
  emlrtMsgIdentifier c2_thisId;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_y), &c2_thisId, c2_b_y_data,
                        c2_b_y_sizes);
  sf_mex_destroy(&c2_y);
}

static void c2_b_emlrt_marshallIn(SFc2_viptraffic_winInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId,
  int32_T c2_b_y_data[], int32_T c2_b_y_sizes[2])
{
  int32_T c2_i23;
  uint32_T c2_uv0[2];
  int32_T c2_i24;
  boolean_T c2_bv0[2];
  int32_T c2_tmp_sizes[2];
  int32_T c2_tmp_data[320];
  int32_T c2_y;
  int32_T c2_b_y;
  int32_T c2_loop_ub;
  int32_T c2_i25;
  (void)chartInstance;
  for (c2_i23 = 0; c2_i23 < 2; c2_i23++) {
    c2_uv0[c2_i23] = 80U + (uint32_T)(-76 * c2_i23);
  }

  for (c2_i24 = 0; c2_i24 < 2; c2_i24++) {
    c2_bv0[c2_i24] = true;
  }

  sf_mex_import_vs(c2_parentId, sf_mex_dup(c2_u), c2_tmp_data, 1, 6, 0U, 1, 0U,
                   2, c2_bv0, c2_uv0, c2_tmp_sizes);
  c2_b_y_sizes[0] = c2_tmp_sizes[0];
  c2_b_y_sizes[1] = c2_tmp_sizes[1];
  c2_y = c2_b_y_sizes[0];
  c2_b_y = c2_b_y_sizes[1];
  c2_loop_ub = c2_tmp_sizes[0] * c2_tmp_sizes[1] - 1;
  for (c2_i25 = 0; c2_i25 <= c2_loop_ub; c2_i25++) {
    c2_b_y_data[c2_i25] = c2_tmp_data[c2_i25];
  }

  sf_mex_destroy(&c2_u);
}

static void c2_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, int32_T c2_outData_data[],
  int32_T c2_outData_sizes[2])
{
  const mxArray *c2_y;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  int32_T c2_b_y_sizes[2];
  int32_T c2_b_y_data[320];
  int32_T c2_loop_ub;
  int32_T c2_i26;
  int32_T c2_b_loop_ub;
  int32_T c2_i27;
  SFc2_viptraffic_winInstanceStruct *chartInstance;
  chartInstance = (SFc2_viptraffic_winInstanceStruct *)chartInstanceVoid;
  c2_y = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_y), &c2_thisId, c2_b_y_data,
                        c2_b_y_sizes);
  sf_mex_destroy(&c2_y);
  c2_outData_sizes[0] = c2_b_y_sizes[0];
  c2_outData_sizes[1] = c2_b_y_sizes[1];
  c2_loop_ub = c2_b_y_sizes[1] - 1;
  for (c2_i26 = 0; c2_i26 <= c2_loop_ub; c2_i26++) {
    c2_b_loop_ub = c2_b_y_sizes[0] - 1;
    for (c2_i27 = 0; c2_i27 <= c2_b_loop_ub; c2_i27++) {
      c2_outData_data[c2_i27 + c2_outData_sizes[0] * c2_i26] =
        c2_b_y_data[c2_i27 + c2_b_y_sizes[0] * c2_i26];
    }
  }

  sf_mex_destroy(&c2_mxArrayInData);
}

static const mxArray *c2_b_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData = NULL;
  real_T c2_u;
  const mxArray *c2_y = NULL;
  SFc2_viptraffic_winInstanceStruct *chartInstance;
  chartInstance = (SFc2_viptraffic_winInstanceStruct *)chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_u = *(real_T *)c2_inData;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", &c2_u, 0, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, false);
  return c2_mxArrayOutData;
}

static real_T c2_c_emlrt_marshallIn(SFc2_viptraffic_winInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  real_T c2_y;
  real_T c2_d3;
  (void)chartInstance;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_d3, 1, 0, 0U, 0, 0U, 0);
  c2_y = c2_d3;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static void c2_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_nargout;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  real_T c2_y;
  SFc2_viptraffic_winInstanceStruct *chartInstance;
  chartInstance = (SFc2_viptraffic_winInstanceStruct *)chartInstanceVoid;
  c2_nargout = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_y = c2_c_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_nargout), &c2_thisId);
  sf_mex_destroy(&c2_nargout);
  *(real_T *)c2_outData = c2_y;
  sf_mex_destroy(&c2_mxArrayInData);
}

static const mxArray *c2_c_sf_marshallOut(void *chartInstanceVoid, real_T
  c2_inData_data[], int32_T c2_inData_sizes[2])
{
  const mxArray *c2_mxArrayOutData = NULL;
  int32_T c2_b_u_sizes[2];
  int32_T c2_u;
  int32_T c2_b_u;
  int32_T c2_inData;
  int32_T c2_b_inData;
  int32_T c2_b_inData_sizes;
  int32_T c2_loop_ub;
  int32_T c2_i28;
  real_T c2_b_inData_data[320];
  int32_T c2_b_loop_ub;
  int32_T c2_i29;
  real_T c2_b_u_data[320];
  const mxArray *c2_y = NULL;
  SFc2_viptraffic_winInstanceStruct *chartInstance;
  chartInstance = (SFc2_viptraffic_winInstanceStruct *)chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_b_u_sizes[0] = c2_inData_sizes[0];
  c2_b_u_sizes[1] = c2_inData_sizes[1];
  c2_u = c2_b_u_sizes[0];
  c2_b_u = c2_b_u_sizes[1];
  c2_inData = c2_inData_sizes[0];
  c2_b_inData = c2_inData_sizes[1];
  c2_b_inData_sizes = c2_inData * c2_b_inData;
  c2_loop_ub = c2_inData * c2_b_inData - 1;
  for (c2_i28 = 0; c2_i28 <= c2_loop_ub; c2_i28++) {
    c2_b_inData_data[c2_i28] = c2_inData_data[c2_i28];
  }

  c2_b_loop_ub = c2_b_inData_sizes - 1;
  for (c2_i29 = 0; c2_i29 <= c2_b_loop_ub; c2_i29++) {
    c2_b_u_data[c2_i29] = c2_b_inData_data[c2_i29];
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_b_u_data, 0, 0U, 1U, 0U, 2,
    c2_b_u_sizes[0], c2_b_u_sizes[1]), false);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, false);
  return c2_mxArrayOutData;
}

static void c2_d_emlrt_marshallIn(SFc2_viptraffic_winInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId,
  real_T c2_b_y_data[], int32_T c2_b_y_sizes[2])
{
  int32_T c2_i30;
  uint32_T c2_uv1[2];
  int32_T c2_i31;
  boolean_T c2_bv1[2];
  int32_T c2_tmp_sizes[2];
  real_T c2_tmp_data[320];
  int32_T c2_y;
  int32_T c2_b_y;
  int32_T c2_loop_ub;
  int32_T c2_i32;
  (void)chartInstance;
  for (c2_i30 = 0; c2_i30 < 2; c2_i30++) {
    c2_uv1[c2_i30] = 80U + (uint32_T)(-76 * c2_i30);
  }

  for (c2_i31 = 0; c2_i31 < 2; c2_i31++) {
    c2_bv1[c2_i31] = true;
  }

  sf_mex_import_vs(c2_parentId, sf_mex_dup(c2_u), c2_tmp_data, 1, 0, 0U, 1, 0U,
                   2, c2_bv1, c2_uv1, c2_tmp_sizes);
  c2_b_y_sizes[0] = c2_tmp_sizes[0];
  c2_b_y_sizes[1] = c2_tmp_sizes[1];
  c2_y = c2_b_y_sizes[0];
  c2_b_y = c2_b_y_sizes[1];
  c2_loop_ub = c2_tmp_sizes[0] * c2_tmp_sizes[1] - 1;
  for (c2_i32 = 0; c2_i32 <= c2_loop_ub; c2_i32++) {
    c2_b_y_data[c2_i32] = c2_tmp_data[c2_i32];
  }

  sf_mex_destroy(&c2_u);
}

static void c2_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, real_T c2_outData_data[], int32_T
  c2_outData_sizes[2])
{
  const mxArray *c2_repVector;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  int32_T c2_b_y_sizes[2];
  real_T c2_b_y_data[320];
  int32_T c2_loop_ub;
  int32_T c2_i33;
  int32_T c2_b_loop_ub;
  int32_T c2_i34;
  SFc2_viptraffic_winInstanceStruct *chartInstance;
  chartInstance = (SFc2_viptraffic_winInstanceStruct *)chartInstanceVoid;
  c2_repVector = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_d_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_repVector), &c2_thisId,
                        c2_b_y_data, c2_b_y_sizes);
  sf_mex_destroy(&c2_repVector);
  c2_outData_sizes[0] = c2_b_y_sizes[0];
  c2_outData_sizes[1] = c2_b_y_sizes[1];
  c2_loop_ub = c2_b_y_sizes[1] - 1;
  for (c2_i33 = 0; c2_i33 <= c2_loop_ub; c2_i33++) {
    c2_b_loop_ub = c2_b_y_sizes[0] - 1;
    for (c2_i34 = 0; c2_i34 <= c2_b_loop_ub; c2_i34++) {
      c2_outData_data[c2_i34 + c2_outData_sizes[0] * c2_i33] =
        c2_b_y_data[c2_i34 + c2_b_y_sizes[0] * c2_i33];
    }
  }

  sf_mex_destroy(&c2_mxArrayInData);
}

static const mxArray *c2_d_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData = NULL;
  int32_T c2_i35;
  real_T c2_b_inData[2];
  int32_T c2_i36;
  real_T c2_u[2];
  const mxArray *c2_y = NULL;
  SFc2_viptraffic_winInstanceStruct *chartInstance;
  chartInstance = (SFc2_viptraffic_winInstanceStruct *)chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  for (c2_i35 = 0; c2_i35 < 2; c2_i35++) {
    c2_b_inData[c2_i35] = (*(real_T (*)[2])c2_inData)[c2_i35];
  }

  for (c2_i36 = 0; c2_i36 < 2; c2_i36++) {
    c2_u[c2_i36] = c2_b_inData[c2_i36];
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 0, 0U, 1U, 0U, 2, 1, 2), false);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, false);
  return c2_mxArrayOutData;
}

static void c2_e_emlrt_marshallIn(SFc2_viptraffic_winInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId,
  real_T c2_y[2])
{
  real_T c2_dv1[2];
  int32_T c2_i37;
  (void)chartInstance;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), c2_dv1, 1, 0, 0U, 1, 0U, 2, 1, 2);
  for (c2_i37 = 0; c2_i37 < 2; c2_i37++) {
    c2_y[c2_i37] = c2_dv1[c2_i37];
  }

  sf_mex_destroy(&c2_u);
}

static void c2_d_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_dim;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  real_T c2_y[2];
  int32_T c2_i38;
  SFc2_viptraffic_winInstanceStruct *chartInstance;
  chartInstance = (SFc2_viptraffic_winInstanceStruct *)chartInstanceVoid;
  c2_dim = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_e_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_dim), &c2_thisId, c2_y);
  sf_mex_destroy(&c2_dim);
  for (c2_i38 = 0; c2_i38 < 2; c2_i38++) {
    (*(real_T (*)[2])c2_outData)[c2_i38] = c2_y[c2_i38];
  }

  sf_mex_destroy(&c2_mxArrayInData);
}

const mxArray *sf_c2_viptraffic_win_get_eml_resolved_functions_info(void)
{
  const mxArray *c2_nameCaptureInfo = NULL;
  c2_nameCaptureInfo = NULL;
  sf_mex_assign(&c2_nameCaptureInfo, sf_mex_create("nameCaptureInfo", NULL, 0,
    0U, 1U, 0U, 2, 0, 1), false);
  return c2_nameCaptureInfo;
}

static void c2_repmat(SFc2_viptraffic_winInstanceStruct *chartInstance, real_T
                      c2_varargin_1, real_T c2_b_data[], int32_T c2_b_sizes[2])
{
  int32_T c2_tile_sizes;
  int32_T c2_loop_ub;
  int32_T c2_i39;
  boolean_T c2_tile_data[80];
  int32_T c2_outsize[2];
  int32_T c2_a;
  real_T c2_b;
  int32_T c2_b_a;
  real_T c2_b_b;
  int32_T c2_idx;
  real_T c2_flt;
  boolean_T c2_p;
  int32_T c2_i40;
  static char_T c2_cv0[15] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 'p', 'm', 'a',
    'x', 's', 'i', 'z', 'e' };

  char_T c2_u[15];
  const mxArray *c2_y = NULL;
  int32_T c2_b_outsize[2];
  int32_T c2_tmp_sizes[2];
  int32_T c2_i41;
  int32_T c2_i42;
  int32_T c2_b_loop_ub;
  int32_T c2_i43;
  real_T c2_tmp_data[320];
  int32_T c2_i44;
  boolean_T c2_b0;
  int32_T c2_ntilerows;
  int32_T c2_jcol;
  int32_T c2_b_jcol;
  int32_T c2_iacol;
  int32_T c2_ibmat;
  int32_T c2_b_ntilerows;
  int32_T c2_c_b;
  int32_T c2_d_b;
  int32_T c2_itilerow;
  int32_T c2_b_itilerow;
  int32_T c2_ibcol;
  static real_T c2_dv2[4] = { 0.0, 21.0, 0.0, 0.0 };

  c2_eml_assert_valid_size_arg(chartInstance, c2_varargin_1);
  c2_tile_sizes = (int32_T)c2_varargin_1;
  c2_loop_ub = (int32_T)c2_varargin_1 - 1;
  for (c2_i39 = 0; c2_i39 <= c2_loop_ub; c2_i39++) {
    c2_tile_data[c2_i39] = false;
  }

  c2_eml_switch_helper(chartInstance);
  c2_outsize[0] = c2_tile_sizes;
  c2_a = c2_outsize[0];
  c2_b = (real_T)c2_tile_sizes;
  c2_b_a = c2_a;
  c2_b_b = c2_b;
  c2_idx = c2_b_a;
  c2_flt = c2_b_b;
  c2_p = ((real_T)c2_idx == c2_flt);
  if (c2_p) {
  } else {
    for (c2_i40 = 0; c2_i40 < 15; c2_i40++) {
      c2_u[c2_i40] = c2_cv0[c2_i40];
    }

    c2_y = NULL;
    sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 10, 0U, 1U, 0U, 2, 1, 15),
                  false);
    sf_mex_call_debug(sfGlobalDebugInstanceStruct, "error", 0U, 1U, 14, c2_y);
  }

  c2_b_outsize[0] = c2_outsize[0];
  c2_b_outsize[1] = 4;
  c2_tmp_sizes[0] = c2_b_outsize[0];
  c2_tmp_sizes[1] = 4;
  c2_i41 = c2_tmp_sizes[0];
  c2_i42 = c2_tmp_sizes[1];
  c2_b_loop_ub = (c2_outsize[0] << 2) - 1;
  for (c2_i43 = 0; c2_i43 <= c2_b_loop_ub; c2_i43++) {
    c2_tmp_data[c2_i43] = 0.0;
  }

  for (c2_i44 = 0; c2_i44 < 2; c2_i44++) {
    c2_b_sizes[c2_i44] = c2_tmp_sizes[c2_i44];
  }

  c2_b0 = (c2_b_sizes[0] == 0);
  if (c2_b0) {
  } else {
    c2_ntilerows = c2_tile_sizes;
    c2_eml_switch_helper(chartInstance);
    for (c2_jcol = 1; c2_jcol < 5; c2_jcol++) {
      c2_b_jcol = c2_jcol - 1;
      c2_iacol = c2_b_jcol;
      c2_ibmat = c2_b_jcol * c2_ntilerows + 1;
      c2_b_ntilerows = c2_ntilerows;
      c2_c_b = c2_b_ntilerows;
      c2_d_b = c2_c_b;
      if (1 > c2_d_b) {
      } else {
        c2_eml_switch_helper(chartInstance);
        c2_eml_switch_helper(chartInstance);
      }

      for (c2_itilerow = 1; c2_itilerow <= c2_b_ntilerows; c2_itilerow++) {
        c2_b_itilerow = c2_itilerow - 1;
        c2_ibcol = c2_ibmat + c2_b_itilerow;
        c2_b_data[_SFD_EML_ARRAY_BOUNDS_CHECK("", c2_ibcol, 1, c2_b_sizes[0] <<
          2, 1, 0) - 1] = c2_dv2[c2_iacol];
      }
    }
  }
}

static void c2_eml_assert_valid_size_arg(SFc2_viptraffic_winInstanceStruct
  *chartInstance, real_T c2_varargin_1)
{
  real_T c2_arg;
  boolean_T c2_p;
  boolean_T c2_b1;
  int32_T c2_i45;
  static char_T c2_cv1[28] = { 'C', 'o', 'd', 'e', 'r', ':', 'M', 'A', 'T', 'L',
    'A', 'B', ':', 'N', 'o', 'n', 'I', 'n', 't', 'e', 'g', 'e', 'r', 'I', 'n',
    'p', 'u', 't' };

  char_T c2_u[28];
  const mxArray *c2_y = NULL;
  int32_T c2_b_u;
  const mxArray *c2_b_y = NULL;
  int32_T c2_c_u;
  const mxArray *c2_c_y = NULL;
  boolean_T guard1 = false;
  c2_arg = c2_varargin_1;
  if (c2_arg != c2_arg) {
    c2_p = false;
  } else {
    c2_p = true;
  }

  guard1 = false;
  if (c2_p) {
    if (c2_isinbounds(chartInstance, c2_varargin_1)) {
      c2_b1 = true;
    } else {
      guard1 = true;
    }
  } else {
    guard1 = true;
  }

  if (guard1 == true) {
    c2_b1 = false;
  }

  if (c2_b1) {
  } else {
    for (c2_i45 = 0; c2_i45 < 28; c2_i45++) {
      c2_u[c2_i45] = c2_cv1[c2_i45];
    }

    c2_y = NULL;
    sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 10, 0U, 1U, 0U, 2, 1, 28),
                  false);
    c2_b_u = MIN_int32_T;
    c2_b_y = NULL;
    sf_mex_assign(&c2_b_y, sf_mex_create("y", &c2_b_u, 6, 0U, 0U, 0U, 0), false);
    c2_c_u = MAX_int32_T;
    c2_c_y = NULL;
    sf_mex_assign(&c2_c_y, sf_mex_create("y", &c2_c_u, 6, 0U, 0U, 0U, 0), false);
    sf_mex_call_debug(sfGlobalDebugInstanceStruct, "error", 0U, 1U, 14,
                      sf_mex_call_debug(sfGlobalDebugInstanceStruct, "message",
      1U, 3U, 14, c2_y, 14, c2_b_y, 14, c2_c_y));
  }
}

static boolean_T c2_isinbounds(SFc2_viptraffic_winInstanceStruct *chartInstance,
  real_T c2_arg)
{
  (void)chartInstance;
  (void)c2_arg;
  return true;
}

static void c2_eml_switch_helper(SFc2_viptraffic_winInstanceStruct
  *chartInstance)
{
  (void)chartInstance;
}

static const mxArray *c2_e_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData = NULL;
  int32_T c2_u;
  const mxArray *c2_y = NULL;
  SFc2_viptraffic_winInstanceStruct *chartInstance;
  chartInstance = (SFc2_viptraffic_winInstanceStruct *)chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_u = *(int32_T *)c2_inData;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", &c2_u, 6, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, false);
  return c2_mxArrayOutData;
}

static int32_T c2_f_emlrt_marshallIn(SFc2_viptraffic_winInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  int32_T c2_y;
  int32_T c2_i46;
  (void)chartInstance;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_i46, 1, 6, 0U, 0, 0U, 0);
  c2_y = c2_i46;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static void c2_e_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_b_sfEvent;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  int32_T c2_y;
  SFc2_viptraffic_winInstanceStruct *chartInstance;
  chartInstance = (SFc2_viptraffic_winInstanceStruct *)chartInstanceVoid;
  c2_b_sfEvent = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_y = c2_f_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_b_sfEvent),
    &c2_thisId);
  sf_mex_destroy(&c2_b_sfEvent);
  *(int32_T *)c2_outData = c2_y;
  sf_mex_destroy(&c2_mxArrayInData);
}

static uint8_T c2_g_emlrt_marshallIn(SFc2_viptraffic_winInstanceStruct
  *chartInstance, const mxArray *c2_b_is_active_c2_viptraffic_win, const char_T *
  c2_identifier)
{
  uint8_T c2_y;
  emlrtMsgIdentifier c2_thisId;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_y = c2_h_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c2_b_is_active_c2_viptraffic_win), &c2_thisId);
  sf_mex_destroy(&c2_b_is_active_c2_viptraffic_win);
  return c2_y;
}

static uint8_T c2_h_emlrt_marshallIn(SFc2_viptraffic_winInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  uint8_T c2_y;
  uint8_T c2_u0;
  (void)chartInstance;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_u0, 1, 3, 0U, 0, 0U, 0);
  c2_y = c2_u0;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static void init_dsm_address_info(SFc2_viptraffic_winInstanceStruct
  *chartInstance)
{
  (void)chartInstance;
}

static void init_simulink_io_address(SFc2_viptraffic_winInstanceStruct
  *chartInstance)
{
  chartInstance->c2_u_data = (int32_T (*)[320])ssGetInputPortSignal_wrapper
    (chartInstance->S, 0);
  chartInstance->c2_u_sizes = (int32_T (*)[2])
    ssGetCurrentInputPortDimensions_wrapper(chartInstance->S, 0);
  chartInstance->c2_y_data = (int32_T (*)[320])ssGetOutputPortSignal_wrapper
    (chartInstance->S, 1);
  chartInstance->c2_y_sizes = (int32_T (*)[2])
    ssGetCurrentOutputPortDimensions_wrapper(chartInstance->S, 1);
}

/* SFunction Glue Code */
#ifdef utFree
#undef utFree
#endif

#ifdef utMalloc
#undef utMalloc
#endif

#ifdef __cplusplus

extern "C" void *utMalloc(size_t size);
extern "C" void utFree(void*);

#else

extern void *utMalloc(size_t size);
extern void utFree(void*);

#endif

void sf_c2_viptraffic_win_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(3595712420U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(818805746U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(1827609311U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(2767140016U);
}

mxArray* sf_c2_viptraffic_win_get_post_codegen_info(void);
mxArray *sf_c2_viptraffic_win_get_autoinheritance_info(void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs", "locals", "postCodegenInfo" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1, 1, sizeof
    (autoinheritanceFields)/sizeof(autoinheritanceFields[0]),
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateString("bicde8aSsTqBvL3MRujScC");
    mxSetField(mxAutoinheritanceInfo,0,"checksum",mxChecksum);
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,1,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(80);
      pr[1] = (double)(4);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(8));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"inputs",mxData);
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,1,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(1);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"parameters",mxData);
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,1,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(80);
      pr[1] = (double)(4);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(8));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"outputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"locals",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  {
    mxArray* mxPostCodegenInfo = sf_c2_viptraffic_win_get_post_codegen_info();
    mxSetField(mxAutoinheritanceInfo,0,"postCodegenInfo",mxPostCodegenInfo);
  }

  return(mxAutoinheritanceInfo);
}

mxArray *sf_c2_viptraffic_win_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

mxArray *sf_c2_viptraffic_win_jit_fallback_info(void)
{
  const char *infoFields[] = { "fallbackType", "fallbackReason",
    "incompatibleSymbol", };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 3, infoFields);
  mxArray *fallbackReason = mxCreateString("feature_off");
  mxArray *incompatibleSymbol = mxCreateString("");
  mxArray *fallbackType = mxCreateString("early");
  mxSetField(mxInfo, 0, infoFields[0], fallbackType);
  mxSetField(mxInfo, 0, infoFields[1], fallbackReason);
  mxSetField(mxInfo, 0, infoFields[2], incompatibleSymbol);
  return mxInfo;
}

mxArray *sf_c2_viptraffic_win_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

mxArray* sf_c2_viptraffic_win_get_post_codegen_info(void)
{
  const char* fieldNames[] = { "exportedFunctionsUsedByThisChart",
    "exportedFunctionsChecksum" };

  mwSize dims[2] = { 1, 1 };

  mxArray* mxPostCodegenInfo = mxCreateStructArray(2, dims, sizeof(fieldNames)/
    sizeof(fieldNames[0]), fieldNames);

  {
    mxArray* mxExportedFunctionsChecksum = mxCreateString("");
    mwSize exp_dims[2] = { 0, 1 };

    mxArray* mxExportedFunctionsUsedByThisChart = mxCreateCellArray(2, exp_dims);
    mxSetField(mxPostCodegenInfo, 0, "exportedFunctionsUsedByThisChart",
               mxExportedFunctionsUsedByThisChart);
    mxSetField(mxPostCodegenInfo, 0, "exportedFunctionsChecksum",
               mxExportedFunctionsChecksum);
  }

  return mxPostCodegenInfo;
}

static const mxArray *sf_get_sim_state_info_c2_viptraffic_win(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  const char *infoEncStr[] = {
    "100 S1x2'type','srcId','name','auxInfo'{{M[1],M[5],T\"y\",},{M[8],M[0],T\"is_active_c2_viptraffic_win\",}}"
  };

  mxArray *mxVarInfo = sf_mex_decode_encoded_mx_struct_array(infoEncStr, 2, 10);
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c2_viptraffic_win_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc2_viptraffic_winInstanceStruct *chartInstance;
    ChartRunTimeInfo * crtInfo = (ChartRunTimeInfo *)(ssGetUserData(S));
    ChartInfoStruct * chartInfo = (ChartInfoStruct *)(crtInfo->instanceInfo);
    chartInstance = (SFc2_viptraffic_winInstanceStruct *)
      chartInfo->chartInstance;
    if (ssIsFirstInitCond(S) && fullDebuggerInitialization==1) {
      /* do this only if simulation is starting */
      {
        unsigned int chartAlreadyPresent;
        chartAlreadyPresent = sf_debug_initialize_chart
          (sfGlobalDebugInstanceStruct,
           _viptraffic_winMachineNumber_,
           2,
           1,
           1,
           0,
           3,
           0,
           0,
           0,
           0,
           0,
           &(chartInstance->chartNumber),
           &(chartInstance->instanceNumber),
           (void *)S);

        /* Each instance must initialize its own list of scripts */
        init_script_number_translation(_viptraffic_winMachineNumber_,
          chartInstance->chartNumber,chartInstance->instanceNumber);
        if (chartAlreadyPresent==0) {
          /* this is the first instance */
          sf_debug_set_chart_disable_implicit_casting
            (sfGlobalDebugInstanceStruct,_viptraffic_winMachineNumber_,
             chartInstance->chartNumber,1);
          sf_debug_set_chart_event_thresholds(sfGlobalDebugInstanceStruct,
            _viptraffic_winMachineNumber_,
            chartInstance->chartNumber,
            0,
            0,
            0);
          _SFD_SET_DATA_PROPS(0,1,1,0,"u");
          _SFD_SET_DATA_PROPS(1,2,0,1,"y");
          _SFD_SET_DATA_PROPS(2,10,0,0,"line_row");
          _SFD_STATE_INFO(0,0,2);
          _SFD_CH_SUBSTATE_COUNT(0);
          _SFD_CH_SUBSTATE_DECOMP(0);
        }

        _SFD_CV_INIT_CHART(0,0,0,0);

        {
          _SFD_CV_INIT_STATE(0,0,0,0,0,0,NULL,NULL);
        }

        _SFD_CV_INIT_TRANS(0,0,NULL,NULL,0,NULL);

        /* Initialization of MATLAB Function Model Coverage */
        _SFD_CV_INIT_EML(0,1,1,0,0,2,0,0,0,0,0);
        _SFD_CV_INIT_EML_FCN(0,0,"eML_blk_kernel",0,-1,156);
        _SFD_CV_INIT_EML_SATURATION(0,1,0,136,-1,154);
        _SFD_CV_INIT_EML_SATURATION(0,1,1,138,-1,154);

        {
          unsigned int dimVector[2];
          dimVector[0]= 80;
          dimVector[1]= 4;
          _SFD_SET_DATA_COMPILED_PROPS(0,SF_INT32,2,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c2_sf_marshallOut,(MexInFcnForType)NULL);
        }

        {
          unsigned int dimVector[2];
          dimVector[0]= 80;
          dimVector[1]= 4;
          _SFD_SET_DATA_COMPILED_PROPS(1,SF_INT32,2,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c2_sf_marshallOut,(MexInFcnForType)
            c2_sf_marshallIn);
        }

        _SFD_SET_DATA_COMPILED_PROPS(2,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c2_b_sf_marshallOut,(MexInFcnForType)c2_b_sf_marshallIn);
        _SFD_SET_DATA_VALUE_PTR_VAR_DIM(0U, *chartInstance->c2_u_data, (void *)
          chartInstance->c2_u_sizes);
        _SFD_SET_DATA_VALUE_PTR_VAR_DIM(1U, *chartInstance->c2_y_data, (void *)
          chartInstance->c2_y_sizes);
        _SFD_SET_DATA_VALUE_PTR(2U, &chartInstance->c2_line_row);
      }
    } else {
      sf_debug_reset_current_state_configuration(sfGlobalDebugInstanceStruct,
        _viptraffic_winMachineNumber_,chartInstance->chartNumber,
        chartInstance->instanceNumber);
    }
  }
}

static const char* sf_get_instance_specialization(void)
{
  return "WAFjF1jmV8ggU6mkhcUZ5D";
}

static void sf_opaque_initialize_c2_viptraffic_win(void *chartInstanceVar)
{
  chart_debug_initialization(((SFc2_viptraffic_winInstanceStruct*)
    chartInstanceVar)->S,0);
  initialize_params_c2_viptraffic_win((SFc2_viptraffic_winInstanceStruct*)
    chartInstanceVar);
  initialize_c2_viptraffic_win((SFc2_viptraffic_winInstanceStruct*)
    chartInstanceVar);
}

static void sf_opaque_enable_c2_viptraffic_win(void *chartInstanceVar)
{
  enable_c2_viptraffic_win((SFc2_viptraffic_winInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_disable_c2_viptraffic_win(void *chartInstanceVar)
{
  disable_c2_viptraffic_win((SFc2_viptraffic_winInstanceStruct*)
    chartInstanceVar);
}

static void sf_opaque_gateway_c2_viptraffic_win(void *chartInstanceVar)
{
  sf_gateway_c2_viptraffic_win((SFc2_viptraffic_winInstanceStruct*)
    chartInstanceVar);
}

static const mxArray* sf_opaque_get_sim_state_c2_viptraffic_win(SimStruct* S)
{
  ChartRunTimeInfo * crtInfo = (ChartRunTimeInfo *)(ssGetUserData(S));
  ChartInfoStruct * chartInfo = (ChartInfoStruct *)(crtInfo->instanceInfo);
  return get_sim_state_c2_viptraffic_win((SFc2_viptraffic_winInstanceStruct*)
    chartInfo->chartInstance);         /* raw sim ctx */
}

static void sf_opaque_set_sim_state_c2_viptraffic_win(SimStruct* S, const
  mxArray *st)
{
  ChartRunTimeInfo * crtInfo = (ChartRunTimeInfo *)(ssGetUserData(S));
  ChartInfoStruct * chartInfo = (ChartInfoStruct *)(crtInfo->instanceInfo);
  set_sim_state_c2_viptraffic_win((SFc2_viptraffic_winInstanceStruct*)
    chartInfo->chartInstance, st);
}

static void sf_opaque_terminate_c2_viptraffic_win(void *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc2_viptraffic_winInstanceStruct*) chartInstanceVar)->S;
    ChartRunTimeInfo * crtInfo = (ChartRunTimeInfo *)(ssGetUserData(S));
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_viptraffic_win_optimization_info();
    }

    finalize_c2_viptraffic_win((SFc2_viptraffic_winInstanceStruct*)
      chartInstanceVar);
    utFree(chartInstanceVar);
    if (crtInfo != NULL) {
      utFree(crtInfo);
    }

    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc2_viptraffic_win((SFc2_viptraffic_winInstanceStruct*)
    chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c2_viptraffic_win(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  if (sf_machine_global_initializer_called()) {
    ChartRunTimeInfo * crtInfo = (ChartRunTimeInfo *)(ssGetUserData(S));
    ChartInfoStruct * chartInfo = (ChartInfoStruct *)(crtInfo->instanceInfo);
    initialize_params_c2_viptraffic_win((SFc2_viptraffic_winInstanceStruct*)
      (chartInfo->chartInstance));
  }
}

static void mdlSetWorkWidths_c2_viptraffic_win(SimStruct *S)
{
  /* Actual parameters from chart:
     line_row
   */
  const char_T *rtParamNames[] = { "line_row" };

  ssSetNumRunTimeParams(S,ssGetSFcnParamsCount(S));

  /* registration for line_row*/
  ssRegDlgParamAsRunTimeParam(S, 0, 0, rtParamNames[0], SS_DOUBLE);
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    mxArray *infoStruct = load_viptraffic_win_optimization_info();
    int_T chartIsInlinable =
      (int_T)sf_is_chart_inlinable(sf_get_instance_specialization(),infoStruct,2);
    ssSetStateflowIsInlinable(S,chartIsInlinable);
    ssSetRTWCG(S,sf_rtw_info_uint_prop(sf_get_instance_specialization(),
                infoStruct,2,"RTWCG"));
    ssSetEnableFcnIsTrivial(S,1);
    ssSetDisableFcnIsTrivial(S,1);
    ssSetNotMultipleInlinable(S,sf_rtw_info_uint_prop
      (sf_get_instance_specialization(),infoStruct,2,
       "gatewayCannotBeInlinedMultipleTimes"));
    sf_update_buildInfo(sf_get_instance_specialization(),infoStruct,2);
    if (chartIsInlinable) {
      ssSetInputPortOptimOpts(S, 0, SS_REUSABLE_AND_LOCAL);
      sf_mark_chart_expressionable_inputs(S,sf_get_instance_specialization(),
        infoStruct,2,1);
      sf_mark_chart_reusable_outputs(S,sf_get_instance_specialization(),
        infoStruct,2,1);
    }

    {
      unsigned int outPortIdx;
      for (outPortIdx=1; outPortIdx<=1; ++outPortIdx) {
        ssSetOutputPortOptimizeInIR(S, outPortIdx, 1U);
      }
    }

    {
      unsigned int inPortIdx;
      for (inPortIdx=0; inPortIdx < 1; ++inPortIdx) {
        ssSetInputPortOptimizeInIR(S, inPortIdx, 1U);
      }
    }

    sf_set_rtw_dwork_info(S,sf_get_instance_specialization(),infoStruct,2);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
  } else {
  }

  ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  ssSetChecksum0(S,(1808717318U));
  ssSetChecksum1(S,(791142059U));
  ssSetChecksum2(S,(4066356860U));
  ssSetChecksum3(S,(541389388U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
  ssSupportsMultipleExecInstances(S,1);
}

static void mdlRTW_c2_viptraffic_win(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c2_viptraffic_win(SimStruct *S)
{
  SFc2_viptraffic_winInstanceStruct *chartInstance;
  ChartRunTimeInfo * crtInfo = (ChartRunTimeInfo *)utMalloc(sizeof
    (ChartRunTimeInfo));
  chartInstance = (SFc2_viptraffic_winInstanceStruct *)utMalloc(sizeof
    (SFc2_viptraffic_winInstanceStruct));
  memset(chartInstance, 0, sizeof(SFc2_viptraffic_winInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c2_viptraffic_win;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c2_viptraffic_win;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c2_viptraffic_win;
  chartInstance->chartInfo.enableChart = sf_opaque_enable_c2_viptraffic_win;
  chartInstance->chartInfo.disableChart = sf_opaque_disable_c2_viptraffic_win;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c2_viptraffic_win;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c2_viptraffic_win;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c2_viptraffic_win;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c2_viptraffic_win;
  chartInstance->chartInfo.mdlStart = mdlStart_c2_viptraffic_win;
  chartInstance->chartInfo.mdlSetWorkWidths = mdlSetWorkWidths_c2_viptraffic_win;
  chartInstance->chartInfo.extModeExec = NULL;
  chartInstance->chartInfo.restoreLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.restoreBeforeLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.storeCurrentConfiguration = NULL;
  chartInstance->chartInfo.callAtomicSubchartUserFcn = NULL;
  chartInstance->chartInfo.callAtomicSubchartAutoFcn = NULL;
  chartInstance->chartInfo.debugInstance = sfGlobalDebugInstanceStruct;
  chartInstance->S = S;
  crtInfo->checksum = SF_RUNTIME_INFO_CHECKSUM;
  crtInfo->instanceInfo = (&(chartInstance->chartInfo));
  crtInfo->isJITEnabled = false;
  crtInfo->compiledInfo = NULL;
  ssSetUserData(S,(void *)(crtInfo));  /* register the chart instance with simstruct */
  init_dsm_address_info(chartInstance);
  init_simulink_io_address(chartInstance);
  if (!sim_mode_is_rtw_gen(S)) {
  }

  sf_opaque_init_subchart_simstructs(chartInstance->chartInfo.chartInstance);
  chart_debug_initialization(S,1);
}

void c2_viptraffic_win_method_dispatcher(SimStruct *S, int_T method, void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c2_viptraffic_win(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c2_viptraffic_win(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c2_viptraffic_win(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c2_viptraffic_win_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
