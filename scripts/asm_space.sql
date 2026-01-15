set pages 150 lines 150
col name for a30

select g.GROUP_NUMBER,
       f.number_disks,
          NAME,
          round(TOTAL_MB/1024)                             as TOTAL_GB,
          TYPE,
          case TYPE
          when 'HIGH' then
               round(TOTAL_MB/3/1024)
          when 'NORMAL' then
               round(TOTAL_MB/2/1024)
          when 'EXTERN' then
               round(TOTAL_MB/1024)
          end                                              as TOTAL_GB_FG,
          round(USABLE_FILE_MB/1024)                       as USABLE_GB,
          case TYPE
          when 'HIGH' then
               round((((TOTAL_MB - REQUIRED_MIRROR_FREE_MB) /3) - USABLE_FILE_MB) * 100 / ((TOTAL_MB - REQUIRED_MIRROR_FREE_MB) /3))
          when 'NORMAL' then
               round((((TOTAL_MB - REQUIRED_MIRROR_FREE_MB) /2) - USABLE_FILE_MB) * 100 / ((TOTAL_MB - REQUIRED_MIRROR_FREE_MB) /2))
          when 'EXTERN' then
               round((TOTAL_MB - REQUIRED_MIRROR_FREE_MB - USABLE_FILE_MB) * 100 / (TOTAL_MB - REQUIRED_MIRROR_FREE_MB))
          end                                              as "%_USED",
          case TYPE
          when 'HIGH' then
               round(USABLE_FILE_MB * 100 / ((TOTAL_MB - REQUIRED_MIRROR_FREE_MB) /3))
          when 'NORMAL' then
               round(USABLE_FILE_MB * 100 / ((TOTAL_MB - REQUIRED_MIRROR_FREE_MB) /2))
          when 'EXTERN' then
               round(USABLE_FILE_MB * 100 /  (TOTAL_MB - REQUIRED_MIRROR_FREE_MB))
          end                                              as "%_FREE"
     from V$ASM_DISKGROUP g,
          (select count(1) number_disks, GROUP_NUMBER from v$asm_disk group by GROUP_NUMBER) f
    where TOTAL_MB > 0 and g.GROUP_NUMBER = f.GROUP_NUMBER
    order by NAME;
