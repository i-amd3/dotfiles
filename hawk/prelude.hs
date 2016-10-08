{-# LANGUAGE ExtendedDefaultRules, OverloadedStrings #-}
import Prelude
import qualified Data.ByteString.Lazy.Char8 as B
import qualified Data.List as L

-- Using: cat ~/test.sql | hawk -- -ad 'sqlInsert'
-- $ cat ~/test.sql
-- a	nn	n	n	l	l	l	l	l	ll
-- 12858318	oke-u16-edge003.*****.net	3	HTTP	79	1474063320	103254	11	1
-- 12858319	oke-u16-edge001.*****.net	3	HTTP	91	1474063380	712138	66	1
-- 12858320	oke-u16-edge000.*****.net	3	HTTP	44	1474063560	19268	41	1
-- 12858321	oke-u16-edge001.*****.net	3	HTTP	91	1474063560	379748133	6	1
-- 12858322	oke-u16-edge000.*****.net	3	HTTP	74	1474063740	60777	11	1
sqlInsert x = L.map ( (\n -> "INSERT INTO (" ++ columns ++ ") VALUE (" ++ n ++ ");") . L.intercalate "," . map (\n -> "\'" ++ n ++ "\'") . L.words . B.unpack ) values
  where
    columns = L.intercalate "," $ L.words $ B.unpack $ head x
    values  = tail x

main = undefined
