;/*
; *                      Microsoft Confidential
; *                      Copyright (C) Microsoft Corporation 1988 - 1991
; *                      All Rights Reserved.
; */
	PAGE	,132								;AN000;
	TITLE	DOS GRAPHICS Command  -	Copy Shared Data
										;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;					;AN000;
;; DOS - GRAPHICS Command
;;                              
;;										;AN000;
;; File Name:  GRCPSD.ASM							;AN000;
;; ----------									;AN000;
;;										;AN000;
;; Description: 								;AN000;
;; ------------ 								;AN000;
;;	 This file contains the COPY_SHARED_DATA module.			;AN000;
;;										;AN000;
;;										;AN000;
;; Documentation Reference:							;AN000;
;; ------------------------							;AN000;
;;	 PLACID Functional Specifications					;AN000;
;;	 OASIS High Level Design						;AN000;
;;	 OASIS GRAPHICS I1 Overview						;AN000;
;;										;AN000;
;; Procedures Contained in This File:						;AN000;
;; ----------------------------------						;AN000;
;;	 COPY_SHARED_DATA - Copy the Shared Data Area from temporary		;AN000;
;;			    build area to resident memory & exit to DOS 	;AN000;
;;										;AN000;
;; Include Files Required:							;AN000;
;; -----------------------							;AN000;
;;	 None									;AN000;
;;										;AN000;
;; External Procedure References:						;AN000;
;; ------------------------------						;AN000;
;;	 None									;AN000;
;;										;AN000;
;; Linkage Instructions:							;AN000;
;; ---------------------							;AN000;
;;	 Refer to GRAPHICS.ASM							;AN000;
;;										;AN000;
;; Change History:								;AN000;
;; ---------------								;AN000;
;;										;AN000;
;;										;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;					;AN000;
				       ;;					;AN000;
				       ;;					;AN000;
CODE	SEGMENT PUBLIC 'CODE'          ;;                                       ;AN000;
	ASSUME CS:CODE,DS:CODE	       ;;					;AN000;
	INCLUDE GRCTRL.EXT	       ;; Bring in external declarations	;AN000;
	INCLUDE GRCTRL.STR	       ;;  for transient command processing	;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;					;AN000;
;;										;AN000;
;; Public Symbols								;AN000;
;;										;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;					;AN000;
				       ;;					;AN000;
   PUBLIC COPY_SHARED_DATA	       ;;					;AN000;
				       ;;					;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;					;AN000;
;;										;AN000;
;; Module Name: 								;AN000;
;;   COPY_SHARED_DATA								;AN000;
;;										;AN000;
;; Input Parameters:								;AN000;
;;   DS : SI - points to the Temporary Shared Data Area 			;AN000;
;;   ES : DI - destination for resident Shared Data Area			;AN000;
;;   BP      - offset for new Shared Data Area (same as DI)			;AN000;
;;   AH    - Function code for exiting to DOS:					;AN000;
;;	     31H : Terminate & Stay Resident - if first time			;AN000;
;;	     4CH : Terminate - if already installed				;AN000;
;;   DX    - resident data segment size in paragraphs				;AN000;
;;										;AN000;
;; Output Parameters:								;AN000;
;;   NONE									;AN000;
;;										;AN000;
;; Data Structures Referenced:							;AN000;
;;   Control Variables								;AN000;
;;										;AN000;
;; Description: 								;AN000;
;;   Copy the Temporary Shared Data area over the installation modules		;AN000;
;;   and terminate (stay resident).  The data is copied immediately		;AN000;
;;   following this module.							;AN000;
;;										;AN000;
;; Called By:									;AN000;
;;   GRAPHICS_INSTALL								;AN000;
;;										;AN000;
;; External Calls:								;AN000;
;;   NONE									;AN000;
;;										;AN000;
;; Logic:									;AN000;
;;   Copy Temporary Shared Data Area						;AN000;
;;   Set PRINT_SCREEN_ALLOWED to YES						;AN000;
;;   Exit to DOS (Function Code 31 or 4C setup by caller)			;AN000;
;;										;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;					;AN000;
				       ;;					;AN000;
COPY_SHARED_DATA  PROC NEAR	       ;;					;AN000;
				       ;;					;AN000;
	REP	MOVSB		       ;; Copy Shared Data from temporary	;AN000;
				       ;;  build area to resident memory	;AN000;
				       ;; Allow print screens now		;AN000;
	MOV	ES:PRINT_SCREEN_ALLOWED,YES					;AN000;
				       ;;					;AN000;
	INT	21H		       ;; Exit					;AN000;
				       ;;					;AN000;
COPY_SHARED_DATA  ENDP		       ;;					;AN000;
				       ;;					;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;					;AN000;
CODE	ENDS									;AN000;
	END COPY_SHARED_DATA							;AN000;
