curl -o gencode.VM31.gtf.gz https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M31/gencode.vM31.chr_patch_hapl_scaff.annotation.gtf.gz
gzcat gencode.VM31.gtf.gz | awk '                    
$3 == "transcript" { 
    tx_id = ""; gene_name = ""; 
    for (i = 1; i <= NF; i++) { 
        if ($i ~ /^transcript_id$/) { 
            tx_id = $(i+1);  
            gsub(/"|;/, "", tx_id);                                
            sub(/\..*/, "", tx_id);                           
        } 
        if ($i ~ /^gene_name$/) { 
            gene_name = $(i+1); 
            gsub(/"|;/, "", gene_name); 
        } 
    } 
    if (tx_id && gene_name) { 
        print tx_id, gene_name; 
    } 
}' >tx2gene.tsv
