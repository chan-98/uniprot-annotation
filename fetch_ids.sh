blastOutFile=$1
cut -f2 $blastOutFile | cut -d '|' -f2 > uniprotIDfile
split -l 10000 uniprotIDFile

for file in `ls x*`;
do
echo $file
jobId=`cat ${file}| paste -sd,| xargs -I{} \
  curl --request POST 'https://rest.uniprot.org/idmapping/run' --form 'ids="{}"' --form 'from="UniProtKB_AC-ID"' --form 'to="UniProtKB"'|jq -r .jobId`
status=RUNNING
echo $status == "RUNNING"
while [ $status == "RUNNING" ];
do
status=`curl "https://rest.uniprot.org/idmapping/status/$jobId"| jq -r '.jobStatus'`
echo $status
sleep 5
done
if [ $status == "FINISHED" ]; then
    curl "https://rest.uniprot.org/idmapping/uniprotkb/results/$jobId"| jq -r -f jq-filter.txt >> uniprot_annot.tsv
fi
done
