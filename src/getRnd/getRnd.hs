import System.Random
import System.Environment
import Text.Read

getRnd :: Int -> IO Int
getRnd x = do
  gen <- getStdGen
  let (n, _) = randomR (1,x) gen :: (Int,StdGen)
  return n

printRnd :: Int -> IO ()
printRnd x = do
  r <- getRnd x
  print r

main :: IO()
main = do
  arg <- getArgs
  let a = if null arg then "10" else head arg
  case readMaybe a of
    Just x -> printRnd x
    Nothing -> printRnd 10

