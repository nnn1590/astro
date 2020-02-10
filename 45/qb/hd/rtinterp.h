/* rtinterp.h - runtime-specific stuff on the interpreter side */

#undef   RTINTERP_H
#define  RTINTERP_H ON  


/**================ Client Error Range Constants =========================
   Embedded BASIC could be used to support a number of different
   "clients", such as Omega, Opus, etc, acting as a macro package.
   Command equivalent and other runtime calls can cause trappable
   runtime errors, where the error is generated by the client. We
   handle this by giving each client their own range of error codes,
   all of which fit in the same runtime error number space as existing
   BASIC runtime error numbers.
   NOTE: These constants must match what's in EBAPI.H.
=======================================================================**/

/**==================== ErrRet ==========================================

ErrRet stores information for special handling of calls to runtime
   entry points by code that expects error returns (see rterror.asm)

=======================================================================**/

typedef struct errRet {
   ushort   saveSP;     /* saved SP; also indicates if mechanism is in use */
   ushort   saveBP;     /* saved BP (in case RT error has changed it)      */
   ushort   saveSI;     /* saved SI (in case RT error has changed it)      */
   ushort   saveDI;     /* saved DI (in case RT error has changed it)      */
   ushort   retAddr;    /* short address of runtime entry point caller     */
   } errRet;

/**========================= EXTERNAL VARIABLES ===============================

context.c includes this file after defining EXTERNAL as empty, causing these
variables to actually be defined.

============================================================================**/
EXTERNAL errRet   PLM errCodeRet;
                              /* stores state for indirect calls to runtime   */

/* CallRtTrap takes as a parameter a far ptr to a function */
ushort FAR CallRtTrap(void (FAR *)(void));
