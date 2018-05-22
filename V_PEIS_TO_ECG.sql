create view V_PEIS_TO_ECG as
select 'TJ'+convert(varchar,LSH) as ApplyCode, 
	'T'+convert(varchar,grbh) as FKey,
	'' as RepCode,
	'TJ'+convert(varchar,grtjbh) as MedicareCode,
	'TJ|'+convert(varchar,grtjbh)+'|'+convert(varchar,zhxmbh) as ClinicCode,	-- TJ|体检编号|组合项目编号
	'' as HospCode,
	3 as ReportProp,
	xm as PatName,
	(case xb when '男' then 1 when '女' then 2 else 3 end) as Gender,
	csrq as Birthday,
	nl as PatientAge,
	dwmc as PatientAgeUnit,
	dz as Address,
	sfz as IDCard,
	dh as Tel,
	'' as BedNumber,
	0 as WardName,
	'' as MedicareAcount,
	'' as ApplyDepartMentCode, -- HIS 体检科室编号，待更正
	'体检科' as ApplyDepartMent,
	'' as ApplyDocNameCode, -- 心电图医生编号，待更正
	'' as ApplyDocName, -- 医生姓名，待更正
	tjrq as ApplyDate,
	zhmc as CheckProject,
	'' as ClincDiagnose
from v_360peis_request_details 
where tjrq > getdate() - 10  and jclx='功能检查' and jccsbz = 0 and
	LISXMDM <> '' and LISxmdm is not null and zhxmlx = '心电图'

-- ReportProp
-- {REPLACE(1,$@门诊)}{REPLACE(2,$@住院)}{REPLACE(3,$@体检)}