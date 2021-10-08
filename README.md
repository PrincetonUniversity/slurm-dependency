Scripts
=======

-   `run_test.sh`: main code that tests the performance on a code on
    different node and task configurations. This code submits one SLURM
    job, waits for it to finish before starting a new one. It creates
    the SLURM script `submit.sh` from the
-   `submit.sh_template`: template for the submission script.
-   `submit.sh`: an example of the SLURM submition script.
-   `node_task.dat`: two column file with number of nodes in the first
    column and number of tasks in the second column. This is where we
    define the set of node/tasks we want to test the code on.

Comment on SLURM dependency
===========================

The important parts are:

1.  save the jobid with the `--parsable` option:

    ``` {.bash org-language="sh"}
    previous_jobid=$(sbatch --parsable submit.sh)
    ```

2.  use the `--dependency` SLURM option:

    ``` {.bash org-language="sh"}
    previous_jobid=$(sbatch --parsable --dependency=afterok:$previous_jobid submit.sh)
    ```
