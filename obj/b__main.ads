pragma Warnings (Off);
pragma Ada_95;
with System;
with System.Parameters;
with System.Secondary_Stack;
package ada_main is

   gnat_argc : Integer;
   gnat_argv : System.Address;
   gnat_envp : System.Address;

   pragma Import (C, gnat_argc);
   pragma Import (C, gnat_argv);
   pragma Import (C, gnat_envp);

   gnat_exit_status : Integer;
   pragma Import (C, gnat_exit_status);

   GNAT_Version : constant String :=
                    "GNAT Version: Pro 21.1 (20210111-93)" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   Ada_Main_Program_Name : constant String := "_ada_main" & ASCII.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure adafinal;
   pragma Export (C, adafinal, "adafinal");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#c899aa9a#;
   pragma Export (C, u00001, "mainB");
   u00002 : constant Version_32 := 16#66132de6#;
   pragma Export (C, u00002, "system__standard_libraryB");
   u00003 : constant Version_32 := 16#d7bfdce3#;
   pragma Export (C, u00003, "system__standard_libraryS");
   u00004 : constant Version_32 := 16#1fecfc9a#;
   pragma Export (C, u00004, "cardgamesB");
   u00005 : constant Version_32 := 16#2fdd7ee7#;
   pragma Export (C, u00005, "cardgamesS");
   u00006 : constant Version_32 := 16#76789da1#;
   pragma Export (C, u00006, "adaS");
   u00007 : constant Version_32 := 16#ffaa9e94#;
   pragma Export (C, u00007, "ada__calendar__delaysB");
   u00008 : constant Version_32 := 16#d86d2f1d#;
   pragma Export (C, u00008, "ada__calendar__delaysS");
   u00009 : constant Version_32 := 16#57c21ad4#;
   pragma Export (C, u00009, "ada__calendarB");
   u00010 : constant Version_32 := 16#31350a81#;
   pragma Export (C, u00010, "ada__calendarS");
   u00011 : constant Version_32 := 16#8f8f7078#;
   pragma Export (C, u00011, "ada__exceptionsB");
   u00012 : constant Version_32 := 16#8a3aeae2#;
   pragma Export (C, u00012, "ada__exceptionsS");
   u00013 : constant Version_32 := 16#51b6c352#;
   pragma Export (C, u00013, "ada__exceptions__last_chance_handlerB");
   u00014 : constant Version_32 := 16#2c60dc9e#;
   pragma Export (C, u00014, "ada__exceptions__last_chance_handlerS");
   u00015 : constant Version_32 := 16#d609aa73#;
   pragma Export (C, u00015, "systemS");
   u00016 : constant Version_32 := 16#adf22619#;
   pragma Export (C, u00016, "system__soft_linksB");
   u00017 : constant Version_32 := 16#4ab0e7e8#;
   pragma Export (C, u00017, "system__soft_linksS");
   u00018 : constant Version_32 := 16#34a8648e#;
   pragma Export (C, u00018, "system__secondary_stackB");
   u00019 : constant Version_32 := 16#27a29df7#;
   pragma Export (C, u00019, "system__secondary_stackS");
   u00020 : constant Version_32 := 16#896564a3#;
   pragma Export (C, u00020, "system__parametersB");
   u00021 : constant Version_32 := 16#915b6eb8#;
   pragma Export (C, u00021, "system__parametersS");
   u00022 : constant Version_32 := 16#ced09590#;
   pragma Export (C, u00022, "system__storage_elementsB");
   u00023 : constant Version_32 := 16#fbcae077#;
   pragma Export (C, u00023, "system__storage_elementsS");
   u00024 : constant Version_32 := 16#ce3e0e21#;
   pragma Export (C, u00024, "system__soft_links__initializeB");
   u00025 : constant Version_32 := 16#5697fc2b#;
   pragma Export (C, u00025, "system__soft_links__initializeS");
   u00026 : constant Version_32 := 16#41837d1e#;
   pragma Export (C, u00026, "system__stack_checkingB");
   u00027 : constant Version_32 := 16#58b6c19b#;
   pragma Export (C, u00027, "system__stack_checkingS");
   u00028 : constant Version_32 := 16#34742901#;
   pragma Export (C, u00028, "system__exception_tableB");
   u00029 : constant Version_32 := 16#8d37ab8e#;
   pragma Export (C, u00029, "system__exception_tableS");
   u00030 : constant Version_32 := 16#ce4af020#;
   pragma Export (C, u00030, "system__exceptionsB");
   u00031 : constant Version_32 := 16#be6ac785#;
   pragma Export (C, u00031, "system__exceptionsS");
   u00032 : constant Version_32 := 16#69416224#;
   pragma Export (C, u00032, "system__exceptions__machineB");
   u00033 : constant Version_32 := 16#bff81f32#;
   pragma Export (C, u00033, "system__exceptions__machineS");
   u00034 : constant Version_32 := 16#aa0563fc#;
   pragma Export (C, u00034, "system__exceptions_debugB");
   u00035 : constant Version_32 := 16#ae133b08#;
   pragma Export (C, u00035, "system__exceptions_debugS");
   u00036 : constant Version_32 := 16#6680d938#;
   pragma Export (C, u00036, "system__img_intS");
   u00037 : constant Version_32 := 16#01838199#;
   pragma Export (C, u00037, "system__tracebackB");
   u00038 : constant Version_32 := 16#96845c28#;
   pragma Export (C, u00038, "system__tracebackS");
   u00039 : constant Version_32 := 16#1f08c83e#;
   pragma Export (C, u00039, "system__traceback_entriesB");
   u00040 : constant Version_32 := 16#f0a17912#;
   pragma Export (C, u00040, "system__traceback_entriesS");
   u00041 : constant Version_32 := 16#e98b9a6e#;
   pragma Export (C, u00041, "system__traceback__symbolicB");
   u00042 : constant Version_32 := 16#9fa412cf#;
   pragma Export (C, u00042, "system__traceback__symbolicS");
   u00043 : constant Version_32 := 16#179d7d28#;
   pragma Export (C, u00043, "ada__containersS");
   u00044 : constant Version_32 := 16#701f9d88#;
   pragma Export (C, u00044, "ada__exceptions__tracebackB");
   u00045 : constant Version_32 := 16#6b52f2d4#;
   pragma Export (C, u00045, "ada__exceptions__tracebackS");
   u00046 : constant Version_32 := 16#e865e681#;
   pragma Export (C, u00046, "system__bounded_stringsB");
   u00047 : constant Version_32 := 16#a1f48b6a#;
   pragma Export (C, u00047, "system__bounded_stringsS");
   u00048 : constant Version_32 := 16#9fe0b5c9#;
   pragma Export (C, u00048, "system__crtlS");
   u00049 : constant Version_32 := 16#03804aca#;
   pragma Export (C, u00049, "system__dwarf_linesB");
   u00050 : constant Version_32 := 16#9bd742a9#;
   pragma Export (C, u00050, "system__dwarf_linesS");
   u00051 : constant Version_32 := 16#5b4659fa#;
   pragma Export (C, u00051, "ada__charactersS");
   u00052 : constant Version_32 := 16#083055ef#;
   pragma Export (C, u00052, "ada__characters__handlingB");
   u00053 : constant Version_32 := 16#21df700b#;
   pragma Export (C, u00053, "ada__characters__handlingS");
   u00054 : constant Version_32 := 16#4b7bb96a#;
   pragma Export (C, u00054, "ada__characters__latin_1S");
   u00055 : constant Version_32 := 16#e6d4fa36#;
   pragma Export (C, u00055, "ada__stringsS");
   u00056 : constant Version_32 := 16#96df1a3f#;
   pragma Export (C, u00056, "ada__strings__mapsB");
   u00057 : constant Version_32 := 16#1e526bec#;
   pragma Export (C, u00057, "ada__strings__mapsS");
   u00058 : constant Version_32 := 16#f11759e8#;
   pragma Export (C, u00058, "system__bit_opsB");
   u00059 : constant Version_32 := 16#0765e3a3#;
   pragma Export (C, u00059, "system__bit_opsS");
   u00060 : constant Version_32 := 16#38aef82e#;
   pragma Export (C, u00060, "system__unsigned_typesS");
   u00061 : constant Version_32 := 16#92f05f13#;
   pragma Export (C, u00061, "ada__strings__maps__constantsS");
   u00062 : constant Version_32 := 16#edec285f#;
   pragma Export (C, u00062, "interfacesS");
   u00063 : constant Version_32 := 16#a0d3d22b#;
   pragma Export (C, u00063, "system__address_imageB");
   u00064 : constant Version_32 := 16#77e53749#;
   pragma Export (C, u00064, "system__address_imageS");
   u00065 : constant Version_32 := 16#64bf6a44#;
   pragma Export (C, u00065, "system__img_unsS");
   u00066 : constant Version_32 := 16#20ec7aa3#;
   pragma Export (C, u00066, "system__ioB");
   u00067 : constant Version_32 := 16#484b5d3c#;
   pragma Export (C, u00067, "system__ioS");
   u00068 : constant Version_32 := 16#ed6ed711#;
   pragma Export (C, u00068, "system__mmapB");
   u00069 : constant Version_32 := 16#a393db17#;
   pragma Export (C, u00069, "system__mmapS");
   u00070 : constant Version_32 := 16#92d882c5#;
   pragma Export (C, u00070, "ada__io_exceptionsS");
   u00071 : constant Version_32 := 16#a8ba7b3b#;
   pragma Export (C, u00071, "system__mmap__os_interfaceB");
   u00072 : constant Version_32 := 16#52ab6463#;
   pragma Export (C, u00072, "system__mmap__os_interfaceS");
   u00073 : constant Version_32 := 16#81d7d711#;
   pragma Export (C, u00073, "system__os_libB");
   u00074 : constant Version_32 := 16#d872da39#;
   pragma Export (C, u00074, "system__os_libS");
   u00075 : constant Version_32 := 16#ec4d5631#;
   pragma Export (C, u00075, "system__case_utilB");
   u00076 : constant Version_32 := 16#e9dc1c27#;
   pragma Export (C, u00076, "system__case_utilS");
   u00077 : constant Version_32 := 16#2a8e89ad#;
   pragma Export (C, u00077, "system__stringsB");
   u00078 : constant Version_32 := 16#b61f86e6#;
   pragma Export (C, u00078, "system__stringsS");
   u00079 : constant Version_32 := 16#e49bce3e#;
   pragma Export (C, u00079, "interfaces__cB");
   u00080 : constant Version_32 := 16#6c9a16d7#;
   pragma Export (C, u00080, "interfaces__cS");
   u00081 : constant Version_32 := 16#2fffb3cf#;
   pragma Export (C, u00081, "system__object_readerB");
   u00082 : constant Version_32 := 16#6e44e490#;
   pragma Export (C, u00082, "system__object_readerS");
   u00083 : constant Version_32 := 16#ce495d74#;
   pragma Export (C, u00083, "system__val_lliS");
   u00084 : constant Version_32 := 16#252ca7d4#;
   pragma Export (C, u00084, "system__val_lluS");
   u00085 : constant Version_32 := 16#269742a9#;
   pragma Export (C, u00085, "system__val_utilB");
   u00086 : constant Version_32 := 16#7aa91c8d#;
   pragma Export (C, u00086, "system__val_utilS");
   u00087 : constant Version_32 := 16#d12f5796#;
   pragma Export (C, u00087, "system__exception_tracesB");
   u00088 : constant Version_32 := 16#d425aff8#;
   pragma Export (C, u00088, "system__exception_tracesS");
   u00089 : constant Version_32 := 16#058103cb#;
   pragma Export (C, u00089, "system__win32S");
   u00090 : constant Version_32 := 16#8c33a517#;
   pragma Export (C, u00090, "system__wch_conB");
   u00091 : constant Version_32 := 16#cd7488a1#;
   pragma Export (C, u00091, "system__wch_conS");
   u00092 : constant Version_32 := 16#9721e840#;
   pragma Export (C, u00092, "system__wch_stwB");
   u00093 : constant Version_32 := 16#e065a4a0#;
   pragma Export (C, u00093, "system__wch_stwS");
   u00094 : constant Version_32 := 16#1f681dab#;
   pragma Export (C, u00094, "system__wch_cnvB");
   u00095 : constant Version_32 := 16#c2c33252#;
   pragma Export (C, u00095, "system__wch_cnvS");
   u00096 : constant Version_32 := 16#ece6fdb6#;
   pragma Export (C, u00096, "system__wch_jisB");
   u00097 : constant Version_32 := 16#42b32b73#;
   pragma Export (C, u00097, "system__wch_jisS");
   u00098 : constant Version_32 := 16#24ec69e6#;
   pragma Export (C, u00098, "system__os_primitivesB");
   u00099 : constant Version_32 := 16#d1f4cf85#;
   pragma Export (C, u00099, "system__os_primitivesS");
   u00100 : constant Version_32 := 16#05c60a38#;
   pragma Export (C, u00100, "system__task_lockB");
   u00101 : constant Version_32 := 16#b7839d1d#;
   pragma Export (C, u00101, "system__task_lockS");
   u00102 : constant Version_32 := 16#b8c476a4#;
   pragma Export (C, u00102, "system__win32__extS");
   u00103 : constant Version_32 := 16#f64b89a4#;
   pragma Export (C, u00103, "ada__integer_text_ioB");
   u00104 : constant Version_32 := 16#2ec7c168#;
   pragma Export (C, u00104, "ada__integer_text_ioS");
   u00105 : constant Version_32 := 16#f4e097a7#;
   pragma Export (C, u00105, "ada__text_ioB");
   u00106 : constant Version_32 := 16#e741155e#;
   pragma Export (C, u00106, "ada__text_ioS");
   u00107 : constant Version_32 := 16#10558b11#;
   pragma Export (C, u00107, "ada__streamsB");
   u00108 : constant Version_32 := 16#67e31212#;
   pragma Export (C, u00108, "ada__streamsS");
   u00109 : constant Version_32 := 16#630374d7#;
   pragma Export (C, u00109, "ada__tagsB");
   u00110 : constant Version_32 := 16#cb8ac80c#;
   pragma Export (C, u00110, "ada__tagsS");
   u00111 : constant Version_32 := 16#796f31f1#;
   pragma Export (C, u00111, "system__htableB");
   u00112 : constant Version_32 := 16#52cb1999#;
   pragma Export (C, u00112, "system__htableS");
   u00113 : constant Version_32 := 16#089f5cd0#;
   pragma Export (C, u00113, "system__string_hashB");
   u00114 : constant Version_32 := 16#f09572e7#;
   pragma Export (C, u00114, "system__string_hashS");
   u00115 : constant Version_32 := 16#99e68086#;
   pragma Export (C, u00115, "system__val_unsS");
   u00116 : constant Version_32 := 16#73d2d764#;
   pragma Export (C, u00116, "interfaces__c_streamsB");
   u00117 : constant Version_32 := 16#066a78a0#;
   pragma Export (C, u00117, "interfaces__c_streamsS");
   u00118 : constant Version_32 := 16#d88b6b5e#;
   pragma Export (C, u00118, "system__file_ioB");
   u00119 : constant Version_32 := 16#71784b16#;
   pragma Export (C, u00119, "system__file_ioS");
   u00120 : constant Version_32 := 16#86c56e5a#;
   pragma Export (C, u00120, "ada__finalizationS");
   u00121 : constant Version_32 := 16#95817ed8#;
   pragma Export (C, u00121, "system__finalization_rootB");
   u00122 : constant Version_32 := 16#99fbd9e3#;
   pragma Export (C, u00122, "system__finalization_rootS");
   u00123 : constant Version_32 := 16#2b9630db#;
   pragma Export (C, u00123, "system__file_control_blockS");
   u00124 : constant Version_32 := 16#65d440e5#;
   pragma Export (C, u00124, "ada__text_io__generic_auxB");
   u00125 : constant Version_32 := 16#16a0e709#;
   pragma Export (C, u00125, "ada__text_io__generic_auxS");
   u00126 : constant Version_32 := 16#0b730489#;
   pragma Export (C, u00126, "system__img_biuS");
   u00127 : constant Version_32 := 16#462dc357#;
   pragma Export (C, u00127, "system__img_llbS");
   u00128 : constant Version_32 := 16#ec15f52b#;
   pragma Export (C, u00128, "system__img_lliS");
   u00129 : constant Version_32 := 16#1a1fb65c#;
   pragma Export (C, u00129, "system__img_llwS");
   u00130 : constant Version_32 := 16#34a9bfbb#;
   pragma Export (C, u00130, "system__img_wiuS");
   u00131 : constant Version_32 := 16#92183162#;
   pragma Export (C, u00131, "system__val_intS");
   u00132 : constant Version_32 := 16#f2c63a02#;
   pragma Export (C, u00132, "ada__numericsS");
   u00133 : constant Version_32 := 16#45d85488#;
   pragma Export (C, u00133, "ada__strings__unboundedB");
   u00134 : constant Version_32 := 16#51c56030#;
   pragma Export (C, u00134, "ada__strings__unboundedS");
   u00135 : constant Version_32 := 16#f0e64fe5#;
   pragma Export (C, u00135, "ada__strings__searchB");
   u00136 : constant Version_32 := 16#c1ab8667#;
   pragma Export (C, u00136, "ada__strings__searchS");
   u00137 : constant Version_32 := 16#e6eadae6#;
   pragma Export (C, u00137, "ada__strings__text_outputS");
   u00138 : constant Version_32 := 16#cd3494c7#;
   pragma Export (C, u00138, "ada__strings__utf_encodingB");
   u00139 : constant Version_32 := 16#37e3917d#;
   pragma Export (C, u00139, "ada__strings__utf_encodingS");
   u00140 : constant Version_32 := 16#c2b98963#;
   pragma Export (C, u00140, "ada__strings__utf_encoding__wide_wide_stringsB");
   u00141 : constant Version_32 := 16#91eda35b#;
   pragma Export (C, u00141, "ada__strings__utf_encoding__wide_wide_stringsS");
   u00142 : constant Version_32 := 16#a1d6147d#;
   pragma Export (C, u00142, "system__compare_array_unsigned_8B");
   u00143 : constant Version_32 := 16#7f0adbfe#;
   pragma Export (C, u00143, "system__compare_array_unsigned_8S");
   u00144 : constant Version_32 := 16#a8025f3c#;
   pragma Export (C, u00144, "system__address_operationsB");
   u00145 : constant Version_32 := 16#c5051440#;
   pragma Export (C, u00145, "system__address_operationsS");
   u00146 : constant Version_32 := 16#b2ec367e#;
   pragma Export (C, u00146, "system__put_imagesB");
   u00147 : constant Version_32 := 16#8b28058f#;
   pragma Export (C, u00147, "system__put_imagesS");
   u00148 : constant Version_32 := 16#1ce84679#;
   pragma Export (C, u00148, "ada__strings__text_output__utilsB");
   u00149 : constant Version_32 := 16#3780fb9b#;
   pragma Export (C, u00149, "ada__strings__text_output__utilsS");
   u00150 : constant Version_32 := 16#70f25dad#;
   pragma Export (C, u00150, "system__atomic_countersB");
   u00151 : constant Version_32 := 16#625587fe#;
   pragma Export (C, u00151, "system__atomic_countersS");
   u00152 : constant Version_32 := 16#bb610d72#;
   pragma Export (C, u00152, "system__machine_codeS");
   u00153 : constant Version_32 := 16#c9a3fcbc#;
   pragma Export (C, u00153, "system__stream_attributesB");
   u00154 : constant Version_32 := 16#84e17e14#;
   pragma Export (C, u00154, "system__stream_attributesS");
   u00155 : constant Version_32 := 16#3e25f63c#;
   pragma Export (C, u00155, "system__stream_attributes__xdrB");
   u00156 : constant Version_32 := 16#ce9a2a0c#;
   pragma Export (C, u00156, "system__stream_attributes__xdrS");
   u00157 : constant Version_32 := 16#8e7cb667#;
   pragma Export (C, u00157, "system__fat_fltS");
   u00158 : constant Version_32 := 16#a84ebf6a#;
   pragma Export (C, u00158, "system__fat_lfltS");
   u00159 : constant Version_32 := 16#d29e1180#;
   pragma Export (C, u00159, "system__fat_llfS");
   u00160 : constant Version_32 := 16#7d3a7626#;
   pragma Export (C, u00160, "system__fat_sfltS");
   u00161 : constant Version_32 := 16#29e7c4fa#;
   pragma Export (C, u00161, "generic_stackB");
   u00162 : constant Version_32 := 16#0dc038b6#;
   pragma Export (C, u00162, "generic_stackS");
   u00163 : constant Version_32 := 16#fd83e873#;
   pragma Export (C, u00163, "system__concat_2B");
   u00164 : constant Version_32 := 16#d4a97da3#;
   pragma Export (C, u00164, "system__concat_2S");
   u00165 : constant Version_32 := 16#2b70b149#;
   pragma Export (C, u00165, "system__concat_3B");
   u00166 : constant Version_32 := 16#dd79f6d6#;
   pragma Export (C, u00166, "system__concat_3S");
   u00167 : constant Version_32 := 16#932a4690#;
   pragma Export (C, u00167, "system__concat_4B");
   u00168 : constant Version_32 := 16#a86d8153#;
   pragma Export (C, u00168, "system__concat_4S");
   u00169 : constant Version_32 := 16#608e2cd1#;
   pragma Export (C, u00169, "system__concat_5B");
   u00170 : constant Version_32 := 16#5157e95d#;
   pragma Export (C, u00170, "system__concat_5S");
   u00171 : constant Version_32 := 16#7268f812#;
   pragma Export (C, u00171, "system__img_boolB");
   u00172 : constant Version_32 := 16#23d0db98#;
   pragma Export (C, u00172, "system__img_boolS");
   u00173 : constant Version_32 := 16#25460443#;
   pragma Export (C, u00173, "system__img_enum_newB");
   u00174 : constant Version_32 := 16#b745acb3#;
   pragma Export (C, u00174, "system__img_enum_newS");
   u00175 : constant Version_32 := 16#b5a547e2#;
   pragma Export (C, u00175, "system__random_numbersB");
   u00176 : constant Version_32 := 16#bc2b9d32#;
   pragma Export (C, u00176, "system__random_numbersS");
   u00177 : constant Version_32 := 16#15692802#;
   pragma Export (C, u00177, "system__random_seedB");
   u00178 : constant Version_32 := 16#3a40f91f#;
   pragma Export (C, u00178, "system__random_seedS");
   u00179 : constant Version_32 := 16#8f461df5#;
   pragma Export (C, u00179, "text_ioS");
   u00180 : constant Version_32 := 16#eca5ecae#;
   pragma Export (C, u00180, "system__memoryB");
   u00181 : constant Version_32 := 16#8f74cc47#;
   pragma Export (C, u00181, "system__memoryS");

   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  ada.characters%s
   --  ada.characters.latin_1%s
   --  interfaces%s
   --  system%s
   --  system.address_operations%s
   --  system.address_operations%b
   --  system.img_bool%s
   --  system.img_bool%b
   --  system.img_enum_new%s
   --  system.img_enum_new%b
   --  system.img_int%s
   --  system.img_lli%s
   --  system.io%s
   --  system.io%b
   --  system.machine_code%s
   --  system.atomic_counters%s
   --  system.atomic_counters%b
   --  system.parameters%s
   --  system.parameters%b
   --  system.crtl%s
   --  interfaces.c_streams%s
   --  interfaces.c_streams%b
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.stack_checking%s
   --  system.stack_checking%b
   --  system.string_hash%s
   --  system.string_hash%b
   --  system.htable%s
   --  system.htable%b
   --  system.strings%s
   --  system.strings%b
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  system.unsigned_types%s
   --  system.img_biu%s
   --  system.img_llb%s
   --  system.img_llw%s
   --  system.img_uns%s
   --  system.img_wiu%s
   --  system.wch_con%s
   --  system.wch_con%b
   --  system.wch_jis%s
   --  system.wch_jis%b
   --  system.wch_cnv%s
   --  system.wch_cnv%b
   --  system.compare_array_unsigned_8%s
   --  system.compare_array_unsigned_8%b
   --  system.concat_2%s
   --  system.concat_2%b
   --  system.concat_3%s
   --  system.concat_3%b
   --  system.concat_4%s
   --  system.concat_4%b
   --  system.concat_5%s
   --  system.concat_5%b
   --  system.traceback%s
   --  system.traceback%b
   --  ada.characters.handling%s
   --  system.case_util%s
   --  system.os_lib%s
   --  system.secondary_stack%s
   --  system.standard_library%s
   --  ada.exceptions%s
   --  system.exceptions_debug%s
   --  system.exceptions_debug%b
   --  system.soft_links%s
   --  system.val_util%s
   --  system.val_util%b
   --  system.val_llu%s
   --  system.val_lli%s
   --  system.wch_stw%s
   --  system.wch_stw%b
   --  ada.exceptions.last_chance_handler%s
   --  ada.exceptions.last_chance_handler%b
   --  ada.exceptions.traceback%s
   --  ada.exceptions.traceback%b
   --  system.address_image%s
   --  system.address_image%b
   --  system.bit_ops%s
   --  system.bit_ops%b
   --  system.bounded_strings%s
   --  system.bounded_strings%b
   --  system.case_util%b
   --  system.exception_table%s
   --  system.exception_table%b
   --  ada.containers%s
   --  ada.io_exceptions%s
   --  ada.strings%s
   --  ada.strings.maps%s
   --  ada.strings.maps%b
   --  ada.strings.maps.constants%s
   --  interfaces.c%s
   --  interfaces.c%b
   --  system.exceptions%s
   --  system.exceptions%b
   --  system.exceptions.machine%s
   --  system.exceptions.machine%b
   --  system.win32%s
   --  ada.characters.handling%b
   --  system.exception_traces%s
   --  system.exception_traces%b
   --  system.memory%s
   --  system.memory%b
   --  system.mmap%s
   --  system.mmap.os_interface%s
   --  system.mmap.os_interface%b
   --  system.mmap%b
   --  system.object_reader%s
   --  system.object_reader%b
   --  system.dwarf_lines%s
   --  system.dwarf_lines%b
   --  system.os_lib%b
   --  system.secondary_stack%b
   --  system.soft_links.initialize%s
   --  system.soft_links.initialize%b
   --  system.soft_links%b
   --  system.standard_library%b
   --  system.traceback.symbolic%s
   --  system.traceback.symbolic%b
   --  ada.exceptions%b
   --  ada.numerics%s
   --  ada.strings.search%s
   --  ada.strings.search%b
   --  ada.strings.utf_encoding%s
   --  ada.strings.utf_encoding%b
   --  ada.strings.utf_encoding.wide_wide_strings%s
   --  ada.strings.utf_encoding.wide_wide_strings%b
   --  system.fat_flt%s
   --  system.fat_lflt%s
   --  system.fat_llf%s
   --  system.fat_sflt%s
   --  system.task_lock%s
   --  system.task_lock%b
   --  system.val_uns%s
   --  ada.tags%s
   --  ada.tags%b
   --  ada.streams%s
   --  ada.streams%b
   --  ada.strings.text_output%s
   --  ada.strings.text_output.utils%s
   --  ada.strings.text_output.utils%b
   --  system.file_control_block%s
   --  system.finalization_root%s
   --  system.finalization_root%b
   --  ada.finalization%s
   --  system.file_io%s
   --  system.file_io%b
   --  system.put_images%s
   --  system.put_images%b
   --  system.stream_attributes%s
   --  system.stream_attributes.xdr%s
   --  system.stream_attributes.xdr%b
   --  system.stream_attributes%b
   --  ada.strings.unbounded%s
   --  ada.strings.unbounded%b
   --  system.val_int%s
   --  system.win32.ext%s
   --  system.os_primitives%s
   --  system.os_primitives%b
   --  ada.calendar%s
   --  ada.calendar%b
   --  ada.calendar.delays%s
   --  ada.calendar.delays%b
   --  ada.text_io%s
   --  ada.text_io%b
   --  ada.text_io.generic_aux%s
   --  ada.text_io.generic_aux%b
   --  ada.integer_text_io%s
   --  ada.integer_text_io%b
   --  system.random_seed%s
   --  system.random_seed%b
   --  system.random_numbers%s
   --  system.random_numbers%b
   --  text_io%s
   --  generic_stack%s
   --  generic_stack%b
   --  cardgames%s
   --  cardgames%b
   --  main%b
   --  END ELABORATION ORDER

end ada_main;
