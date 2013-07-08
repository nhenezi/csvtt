import System.Environment
import Data.List

type Row = [String]
type Matrix = [Row]

-- splits string after each occurrence of delim
split :: Char -> String -> Row
split delim [] = [""]
split delim (c:cs)
   | c == delim = "" : rest
   | otherwise = (c : head rest) : tail rest
   where
       rest = split delim cs

-- converts a CSV to Matrix
csvToList :: Char -> String -> Matrix
csvToList delim s = map (split delim) (lines s)

-- apply f to elements in matrix
mmap :: (a -> b) -> [[a]] -> [[b]]
mmap f = map (map f)

-- rowLength ["sample", "as", ""] returns [6, 2, 0], nuff said
rowLength :: Row -> [Int]
rowLength = map length

-- Finds maximum length in each row
maxRowLength :: Matrix -> [Int]
maxRowLength = map (maximum . rowLength)

columnLength = rowLength.transpose
maxColumnLength = maxRowLength.transpose

-- extends string s for n characters (with whitespace)
extendStringFor :: Int -> String -> String
extendStringFor 0 s = s
extendStringFor n s = extendStringFor (n-1) s ++ " "

-- extends string s up to n characters (with whitespace)
extendStringTo :: Int -> String -> String
extendStringTo n s = extendStringFor (n - length s) s

-- Resizes each row
resizeRow :: [Int] -> Row -> Row
resizeRow = zipWith extendStringTo

-- Makes all fiels in table same width
sameSizeTable :: Matrix -> Matrix
sameSizeTable x = map (resizeRow (maxColumnLength x)) x

-- Converts matrix to string, separates fields with splitter
makeTable :: String -> Matrix -> String
makeTable _ [] = ""
makeTable splitter [x] = foldr (\x y -> x ++ splitter ++ y) "" x
makeTable splitter (x:xs) = makeTable splitter [x] ++ "\n" ++ makeTable splitter xs

main = do
  (inFile:output) <- getArgs
  let outFile = head output
  file <- readFile inFile
  let list = csvToList ',' file
  writeFile outFile $ makeTable " " (sameSizeTable (tail list))
