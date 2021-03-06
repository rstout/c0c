{- L1 Compiler

   Main compiler module; takes a job and compiles it
-}
module Hcc.Compile
       ( compile
       --, Job(..)
       --, defaultJob
       --, OF(..)
       ) where

import System.FilePath
import System.Process
import System.Exit
import Data.Functor

import Control.Monad.Error

import Hcc.Compile.Types
import Hcc.Compile.Frontend
import Hcc.Compile.IR
import Hcc.Compile.Backend

--import LiftIOE

compile :: SourceCode -> Either String [SimpleStmt]
compile s = genIR <$> (genAST s)

{-

writer file obj = liftIOE $ writeFile file $ show obj

compile :: Job -> IO ()
compile job = do
  res <- runErrorT $ do
    ast <- parseAST $ jobSource job
    liftEIO $ checkAST ast
    if jobOutFormat job == C0
      then writer (jobOut job) ast
      else let asm = codeGen ast in
             if jobOutFormat job == Asm
                then writer (jobOut job) asm
                else do writer asmFile ast
                        let o = if jobOutFormat job == Obj then "-c" else ""
                        gcc o asmFile (jobOut job)
  case res of
    Left msg -> error msg
    Right () -> return ()
  where asmFile = replaceExtension (jobOut job) "S"

gcc :: String -> FilePath -> FilePath -> ErrorT String IO ()
gcc args input output = exitErrorCode $ readProcessWithExitCode
  "gcc"
  [args, input, "-o", output]
  ""
  where exitErrorCode :: IO (ExitCode, String, String) -> ErrorT String IO ()
        exitErrorCode m = do
          (exitCode, _, msg) <- lift m
          case exitCode of
            ExitSuccess   -> return ()
            ExitFailure n -> throwError $ "Error " ++ (show n) ++ "\n" ++ msg
-}
