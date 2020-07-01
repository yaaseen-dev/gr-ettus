/* -*- c++ -*- */

#define RFNOC_EXAMPLE_API
#define ETTUS_API

%include "gnuradio.i"/*			*/// the common stuff

//load generated python docstrings
%include "rfnoc_example_swig_doc.i"



%ignore gr::uhd::device3::get_device;
%rename("set_arg_int") set_arg(const std::string&, const int, const size_t);
%rename("set_arg_double") set_arg(const std::string&, const double, const size_t);
%rename("set_arg_str") set_arg(const std::string&, const std::string&, const size_t);
//Header from gr-ettus
%include "ettus/device3.h"
%include "ettus/rfnoc_block.h"
%include "ettus/rfnoc_block_impl.h"

%{
#include "ettus/device3.h"
#include "ettus/rfnoc_block_impl.h"
%}

