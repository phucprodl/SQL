use master 
go
IF EXISTS (SELECT NAME FROM SYS.DATABASES WHERE NAME='QUANLYSANPHAM')
	DROP DATABASE QUANLYSANPHAM
go
create database QUANLYSANPHAM
ON(NAME='QLSP_DATA',FILENAME='D:\SQL\QLSP.MDF')
LOG ON(NAME='QLSP_LOG',FILENAME='D:\SQL\QLSP.LDF')
GO 

go
use QUANLYSANPHAM
go
set dateformat dmy

CREATE TABLE LOAISP
(
	MALOAI CHAR(5) PRIMARY KEY,
	TENLOAI NVARCHAR(50)
)

CREATE TABLE SANPHAM
(
	MASP CHAR(5) PRIMARY KEY,
	TENSP NVARCHAR(50),
	MOTA NVARCHAR(50),
	GIA INT,
	MALOAI CHAR(5) FOREIGN KEY REFERENCES LOAISP(MALOAI)
)

CREATE TABLE KHACHHANG
(
	MAKH CHAR(5) PRIMARY KEY,
	TENKH NVARCHAR(50),
	DC NVARCHAR(50),
	DT INT
)


CREATE TABLE DONDH
(
	SODDH CHAR(5) PRIMARY KEY,
	NGAYDAT DATE,
	MAKH CHAR(5) FOREIGN KEY REFERENCES KHACHHANG(MAKH)
)

CREATE TABLE CTDDH
(
	SODDH CHAR(5) FOREIGN KEY REFERENCES DONDH(SODDH),
	MASP CHAR(5)  FOREIGN KEY REFERENCES SANPHAM(MASP),
	PRIMARY KEY(SODDH, MASP),
	SOLUONG INT
)

CREATE TABLE NGUYENLIEU
(
	MANL CHAR(5) PRIMARY KEY,
	TENNL NVARCHAR(50),
	DVT NVARCHAR(50),
	GIA INT
)

CREATE TABLE LAM 
(
	MANL CHAR(5) FOREIGN KEY REFERENCES NGUYENLIEU(MANL),
	MASP CHAR(5) FOREIGN KEY REFERENCES SANPHAM(MASP),
	PRIMARY KEY(MANL, MASP),
	SOLUONG FLOAT
)

-------Nhập Dữ liệu
INSERT INTO LOAISP (MALOAI, TENLOAI)
VALUES ('L01',N'Tủ'),
       ('L02',N'Bàn'),
	   ('L03',N'Giường');

INSERT INTO SANPHAM(MASP, TENSP, MOTA, GIA, MALOAI)
VALUES ('SP01', N'Tủ trang điểm', N'Cao 1.4m, rộng 2.2m', '1000000',N'L01'),
       ('SP02', N' Giường đơn Cali', N'Rộng 1.4m', '1500000','L03'),
	   ('SP03', N' Tủ DDA', N'Cao 1.6m, rộng 2.0m, cửa kiếng', '800000', N'L01'),
	   ('SP04', N' Bàn ăn', N' 1m x 1.5m', '650000','L02'),
       ('SP05', N' Bàn uống trà Tròn', N' 1.8m', '1100000',N'L02');

INSERT INTO KHACHHANG(MAKH, TENKH, DC, DT)
VALUES ('KH001',N' Trần Hải Cường',N' 731 Trần Hưng Đạo, Q.1, TP.HCM', 08-9776655),
       ('KH002',N' Nguyễn Thị Bé',N'638 Nguyễn Văn Cừ, Q.5, TP.HCM', 0913-666123),
       ('KH003',N' Trần Thị Minh Hòa',N' 543 Mai Thị Lựu, Ba Đình, Hà Nội',04-9238777),
       ('KH004',N'Phạm Đình Tuân',N' 975 Lê Lai, P.3, TP.Vũng Tàu', 064-543678),
       ('KH005',N' Lê Xuân Nguyện',N' 450 Trưng Vương, Mỹ Tho, Tiền Giang', 073-987123),
       ('KH006',N' Văn Hùng Dũng',N' 291 Hồ Văn Huê, Q.PN, TP.HCM', 08-8222111),
       ('KH012',N' Lê Thị Hương Hoa',N' 980 Lê Hồng Phong, TP.Vũng Tàu', 064-452100),
       ('KH016',N' Hà Minh Trí',N' 332 Nguyễn Thái Học, TP.Quy Nhơn', 056-565656);


INSERT INTO DONDH (SoDDH, NgayDat, MAKH) 
VALUES
('DH001','15/03/2010','KH001'),
('DH002','15/03/2010','KH016'),
('DH003','16/03/2010','KH003'),
('DH004','16/03/2010','KH012'),
('DH005','17/03/2010','KH001'),
('DH006','01/04/2010','KH002');

INSERT INTO CTDDH(SODDH, MASP, SOLUONG)
VALUES (N'DH001',N'SP01', 5),
       (N'DH001',N'SP03', 1),
	   (N'DH002',N'SP02' ,2),
       (N'DH003',N'SP01', 2),
       (N'DH003',N'SP04', 10),
       (N'DH003',N'SP05', 5),
       (N'DH004',N'SP02', 2),
       (N'DH004',N'SP05', 2),
       (N'DH005',N'SP03', 3),
       (N'DH006',N'SP02', 4),
       (N'DH006',N'SP04',3),
       (N'DH006',N'SP05', 6);
INSERT INTO NGUYENLIEU (MaNL, TenNL, DVT, Gia)
VALUES
('NL01','Gỗ Lim XP','m3','1200000'),
('NL02','Gỗ Sao NT','m3','1000000'),
('NL03','Gỗ tạp nham','m3','500000'),
('NL04','Đinh lớn','Kg','40000'),
('NL05','Đinh nhỏ','Kg','30000'),
('NL06','Kiếng','m2','35000');
INSERT INTO LAM (MaNL, MASP, SoLuong)
VALUES
('NL01','SP01','1.2'),
('NL03','SP01','0.3'),
('NL06','SP01','2.5'),
('NL02','SP02','1.1'),
('NL04','SP02','2.2'),
('NL02','SP03','0.9'),
('NL05','SP03','2.1'),
('NL02','SP04','1.3'),
('NL04','SP04','1.7'),
('NL03','SP05','0.8'),
('NL05','SP05','0.5'),
('NL06','SP05','2.4');

--Danh sách các loại sản phẩm có nhiều sản phẩm nhất (Tên loại SP, số sản phẩm) 
create view VCaua
as
	select TOP 1 h.TENLOAI, COUNT (h.MALOAI) AS [SỐ SẢN PHẨM]
	FROM LOAISP H, SANPHAM K
	WHERE H.MALOAI = K.MALOAI
	GROUP BY h.TENLOAI
	ORDER BY  COUNT (h.MALOAI) DESC
--b) Danh sách khách hàng không đặt hàng trong tháng 3/2010 (Tên KH, địa chỉ).
create view VCaub
as
	SELECT S.TENKH, S.DC
	FROM KHACHHANG S
	WHERE S.MAKH NOT in(SELECT C.MAKH 
	FROM DONDH C INNER JOIN CTDDH H
	ON H.SODDH = C.SODDH 
	WHERE month(NgayDat)= 3 and year(NgayDat)= 2010)
--c) DS khách hàng đặt nhiều đơn đặt hàng nhất trong tháng 3/2010 (Tên KH, địa chỉ).
create view VCauc
as
	SELECT TOP 1 S.TENKH, S.DC
	FROM KHACHHANG S, CTDDH H,DONDH C
	WHERE S.MAKH=c.MAKH and h.SoDDH=c.SoDDH and month(NgayDat)= 3 and year(NgayDat)= 2010
	GROUP BY S.TENKH, S.DC 
	ORDER BY COUNT (h.SoDDH) DESC
--Danh sách các sản phẩm không được đặt trong tháng 3/2010 (Tên SP, mô tả).
create view VCaud
as
SELECT S.TENSP, S.MOTA
	FROM SANPHAM S
	WHERE S.MASP NOT in(SELECT H.MASP 
	FROM CTDDH H  INNER JOIN DONDH C
	ON H.SODDH = C.SODDH 
	WHERE month(NgayDat)= 3 and year(NgayDat)= 2010)

--e) Danh sách khách hàng có đặt trên 10 cái tủ DDA (Tên KH, địa chỉ, tổng số lượng).
create view VCaue
as
	SELECT S.TENKH, S.DC, sum(h.SOLUONG) AS [Tổng Số Lượng]
	FROM KHACHHANG S, CTDDH H,DONDH C
	WHERE S.MAKH=c.MAKH and  h.SoDDH=c.SoDDH and h.MASP = 'SP03'
	GROUP BY S.TENKH, S.DC 
	having sum(h.SOLUONG) > 10

--DS các sản phẩm được làm từ nhiều loại nguyên liệu nhất (Tên SP, Giá, Số loại).
create view VCauf
as
SELECT TOP 1 H.TENSP, H.GIA , COUNT (Z.MaNL) AS [SỐ LOẠI]
	FROM SANPHAM H, LAM Z
	WHERE H.MASP = Z.MASP 
	GROUP BY H.TENSP, H.GIA
	ORDER BY COUNT (Z.MaNL) DESC
--Danh sách các sản phẩm có giá thành SX hơn 1 triệu (Tên SP, Giá thành SX)
create view VCaug
as
SELECT H.TENSP, sum(z.SOLUONG*x.GIA) AS [Giá thành SX]
	FROM SANPHAM H, LAM Z, NGUYENLIEU X
	WHERE H.MASP = Z.MASP and z.MANL = x.MANL
	GROUP BY H.TENSP, H.MASP
--DS các sản phẩm có lãi trên 20% (Tên SP, Giá thành SX, Giá bán, phần trăm lãi).
create view VCauh
as
SELECT H.TENSP, sum(z.SOLUONG*x.GIA) AS [Giá thành SX], h.GIA,ROUND((h.GIA / sum(z.SOLUONG*x.GIA) *100), 2) as Lai
	FROM SANPHAM H, LAM Z, NGUYENLIEU X
	WHERE H.MASP = Z.MASP and z.MANL = x.MANL
	GROUP BY H.TENSP, h.GIA, H.MASP
--Danh sách đơn đặt hàng có tổng số tiền lớn hơn 100 triệu (Số DDH, Ngày đặt, Tổng tiền).
create view VCaui
as
SELECT h.SODDH,h.NgayDat,Sum(z.SOLUONG*k.Gia) as Tong
	from DONDH h, CTDDH z, SANPHAM k
	where h.SODDH=z.SODDH and z.MaSP = k. MaSP
	GROUP BY h.SODDH,h.NgayDat
	having Sum(z.SOLUONG*k.Gia) > 10000000
--Danh sách các loại nguyên liệu dùng để làm tất cả các sản phẩm (TênNL, Giá).
create view VCauj
as
select l.TenNL, l.Gia
	from NGUYENLIEU l
--k) Danh sách khách hàng có đặt tất cả các sản phẩm (Tên KH, DC).
create view VCauk
as
	SELECT TENKH, DC
	FROM KHACHHANG A JOIN DONDH B ON A.MAKH=B.MAKH JOIN CTDDH C ON B.SODDH=C.SODDH JOIN SANPHAM D ON C.MASP=D.MASP
	GROUP BY TENKH,DC
--l) Danh sách các sản phẩm tất cả các khách hàng đều đặt (Tên SP, Mô tả).
create view VCaul
as
	SELECT TENSP,MOTA
	FROM SANPHAM A JOIN CTDDH B ON A.MASP = B.MASP JOIN DONDH C ON B.SODDH= C.SODDH JOIN KHACHHANG D ON C.MAKH=D.MAKH
	GROUP BY TENSP,MOTA
	HAVING COUNT(C.MAKH)=(SELECT COUNT(MAKH) FROM KHACHHANG)



---PROC

--a) Liệt kê DS khách hàng (TênKH, DC) có đặt hàng vào Ngày tháng năm X.
CREATE PROCEDURE P_Caua(@ngaydat date)
AS
select DC, TENKH
FROM KHACHHANG K, DONDH D
WHERE K.MAKH = D.MAKH AND D.NgayDat = @ngaydat

exec P_Caua '16-03-2010'
--b) Liệt kê DS khách hàng (TênKH, DC) có đặt hàng sản phẩm có mã số X.
CREATE PROCEDURE P_Caub(@masp varchar(5))
AS
SELECT S.TENKH, S.DC
	from khachhang S, DONDH h, CTDDH z, SANPHAM k
	where s.MAKH= h.MAKH and h.SODDH=z.SODDH and z.MaSP = @masp
	GROUP BY S.TENKH, S.DC,h.SODDH,z.MaSP
exec P_Caub'SP03'
--c) Liệt kê DS khách hàng (TênKH, DC) có đặt hàng với tổng số tiền trên X (1 đơn).
CREATE PROCEDURE P_Cauc(@tongtien int)
AS
SELECT S.TENKH, S.DC,Sum(z.SOLUONG*k.Gia) as Tong
	from khachhang S, DONDH h, CTDDH z, SANPHAM k
	where s.MAKH= h.MAKH and h.SODDH=z.SODDH and z.MaSP = k. MaSP
	GROUP BY S.TENKH, S.DC,h.SODDH
	having Sum(z.SOLUONG*k.Gia) > @tongtien
drop PROCEDURE P_Cauc 
exec P_Cauc '200000'
--d) Liệt kê DS khách hàng (TênKH, DC) có đặt hàng với tổng số tiền trên X (tất cả).
CREATE PROCEDURE P_Caud(@tongtien int)
AS
SELECT S.TENKH, S.DC,Sum(z.SOLUONG*k.Gia) as Tong
	from khachhang S, DONDH h, CTDDH z, SANPHAM k
	where s.MAKH= h.MAKH and h.SODDH=z.SODDH and z.MaSP = k. MaSP
	GROUP BY S.TENKH, S.DC,h.SODDH
	having Sum(z.SOLUONG*k.Gia) > @tongtien
--e) Liệt kê DS sản phẩm (TênSP, Giá thành SX, Giá) bán lãi trên X.
CREATE PROCEDURE P_Caue(@lai int)
AS
SELECT H.TENSP, sum(z.SOLUONG*x.GIA) AS [Giá thành SX], h.GIA,ROUND((h.GIA / sum(z.SOLUONG*x.GIA) *100), 2) as Lai
	FROM SANPHAM H, LAM Z, NGUYENLIEU X
	WHERE H.MASP = Z.MASP and z.MANL = x.MANL
	GROUP BY H.TENSP, h.GIA, H.MASP
	having ROUND((h.GIA / sum(z.SOLUONG*x.GIA) *100), 2) > @lai
exec P_Caue '50'
-- Liệt kê DS sản phẩm (TênSP, Số đơn) có tổng số đơn đặt hàng trên X.
CREATE PROCEDURE P_Caug(@sodon int)
AS
SELECT H.TENSP, count(x.SODDH) as Sodon
	FROM SANPHAM H, CTDDH x
	WHERE H.MASP = x.MASP 
	GROUP BY H.TENSP, h.MASP
	having count(x.SODDH) > @sodon
exec P_Caug '2'
--h) Liệt kê DS sản phẩm (TênSP, Tổng SL) có tổng số lượng đặt hàng trên X.
CREATE PROCEDURE P_Cauh(@soluong int)
AS
SELECT H.TENSP, sum(x.SOLUONG) as SoLuong
	FROM SANPHAM H, CTDDH x
	WHERE H.MASP = x.MASP 
	GROUP BY H.TENSP, h.MASP
	having sum(x.SOLUONG) > @soluong
exec P_Cauh 10






-- Trigger 
-- Mỗi ngày mỗi kháach hàng chỉ đặt tối đa 2 đơn hàng.
CREATE TRIGGER Trig8a ON DONDH
FOR INSERT, UPDATE
AS
	IF(EXISTS ( SELECT A.MAKH, COUNT(A.SoDDH)
			   FROM PHIEUXUAT A
			  WHERE DAY (a.NgayDat) = 1
			   GROUP BY A.MAPX 
			   HAVING COUNT(A.SoDDH) > 2))
BEGIN
		PRINT 'MOI KHACH HANG CHI DUOC DAT 2 DON HANG TRONG 1 NGAY'
		ROLLBACK TRAN
END

--Mỗi đơn đặt hàng có tổng số lượng sản phẩm không quá 100.
CREATE TRIGGER Trig8B 
ON CTDDH
FOR UPDATE,INSERT
AS
    BEGIN
    DECLARE @SL INT 
    SET @SL=(SELECT SOLUONG FROM CTDDH)
    IF(@SL>100)
        BEGIN
        PRINT '-Mỗi đơn đặt hàng có tổng số lượng sản phẩm không quá 100 '
        ROLLBACK TRAN 
        END
        END
--Đảm bảo rằng mỗi sản phẩmc không bị lỗ hơn 50%.
CREATE TRIGGER Trig8c
ON CTDDH
FOR UPDATE,INSERT
AS
    BEGIN
    DECLARE @Lai float 
    SET @Lai=(SELECT ROUND((h.GIA / sum(z.SOLUONG*x.GIA) *100), 2) FROM SANPHAM H, LAM Z, NGUYENLIEU X where H.MASP = Z.MASP and z.MANL = x.MANL GROUP BY H.TENSP, h.GIA, H.MASP)
    IF(@Lai<50)
        BEGIN
        PRINT 'Đảm bảo rằng mỗi sản phẩmc không bị lỗ hơn 50%'
        ROLLBACK TRAN
        END
        END






--Cursor
CREATE PROC LIETKE (@X INT , @Y VARCHAR(5))
AS
BEGIN
print ''
DECLARE CursorA CURSOR scroll for
SELECT TOP (@X) H.TENSP,H.MOTA, H.GIA
	FROM SANPHAM H
	WHERE H.MALOAI = @Y 
	GROUP BY H.TENSP,H.MOTA, H.GIA
	ORDER BY  (H.GIA) desc
	OPEN CursorA
	FETCH CursorA
	while @@FETCH_STATUS = 0
	begin 
	Fetch Next From CursorA
	end 
	DEALLOCATE CursorA
END
LIETKE 3,L01
----Viết thủ tục cập nhật giá cho bảng sản phẩm như sau:
--Những sản phẩm có lãi trên 30% thì giảm giá 10%
--Những sản phẩm bị lỗ thì cập nhật giá bằng giá thành SX
--Những sản phẩm khác thì tăng 5%






--Viết thủ tục in ra thống kê đặt hàng trong tháng X (nhập khi gọi thủ tục)
CREATE PROC LIETKE2 (@X int)
AS
BEGIN
DECLARE CursorB CURSOR scroll for
SELECT h.NGAYDAT,h.SODDH,H.MAKH, sum(z.SOLUONG * s.GIA) as Tong
	FROM DONDH H, SANPHAM s, CTDDH z
	WHERE h.SODDH = z.SODDH and z.MASP = s.MASP and Month(h.Ngaydat) = @X 
	GROUP BY H.SODDH,H.MAKH,h.NGAYDAT
	OPEN CursorB
	FETCH CursorB
	while @@FETCH_STATUS = 0
	begin 
	Fetch Next From CursorB
	end 
	DEALLOCATE CursorB
END
LIETKE2 03
Drop PROC LIETKE2 








---Phân quyền


GRANT ALL ON LAM TO GIAMDOC;
GRANT ALL ON NGUYENLIEU TO GIAMDOC;
GRANT ALL ON CTDDH TO GIAMDOC;
GRANT ALL ON DONDH TO GIAMDOC;
GRANT ALL ON KHACHHANG TO GIAMDOC;
GRANT ALL ON SANPHAM TO GIAMDOC;
GRANT ALL ON LOAISP TO GIAMDOC;
