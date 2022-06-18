local M = {}


function printN(msg)
    vim.notify(msg, "info", {
        title = 'Tags',
        timeout = 1000,
    })
end

function load_ctags(tags_dir)
    local tag_fp = tags_dir .. 'ctags'
    if (vim.fn.filereadable(tagfp) == 1)
    then
        if (vim.fn.executable('ctags') ==1 )
        then
            printN("Loading ctags: " .. tagfp)
            vim.fn.execute("set tags=" .. tagfp)
        else
            printN("ctags is invaild")
        end
    end
end

function load_cscope(tags_dir)
    local cscope_fp = tags_dir .. 'cscope.out'
    if (vim.fn.filereadable(cscope_fp) == 1)
    then
        if (vim.fn.executable('cscope') == 1)
        then
            printN("[cscope] cs add :" .. cscope_fp)
            vim.fn.execute("cs add " .. cscope_fp)
        end
    end
end

function gtags_updating()
    --vim.cmd [[au BufWritePost *.[ch] call UpdatingGtags(expand('<afile>'))]]
    vim.api.nvim_create_autocmd("BufWritePost *.[ch]", {
        nested = true,
        callback = function()
            local f = vim.fn.expand('<afile>')
            local dir = vim.fn.fnamemodify(f, ':p:h')
            --坚决不用gtags -u这个命令有很大的弊端　　会产生很多小的进程在后台　所以基本上这个命令也被gtags官方都否认了
            vim.fn.execute('silent !cd ' .. dir .. ' && gtags --single-update ' .. f .. ' &> /dev/null &')
            --print("GTAGS Updateing:" .. f)
        end
    })
end

function gtags_env_setup(rootdir, tagsdir)
    -- vim.api.nvim_command(":set csto=0 ")
    -- vim.api.nvim_command(":set cst")
    -- vim.api.nvim_command(":set cspc=0")
    -- vim.api.nvim_command(":set cscopequickfix=s0,c0,d0,i0,t0,e0 ")
    -- vim.api.nvim_command(":set csprg=gtags-cscope") -- csprg==cscopeprg
    
    root_dir = vim.fn.simplify(rootdir)
    tags_dir = vim.fn.simplify(tagsdir)

    vim.cmd ("let $GTAGSROOT=" .. '"' .. root_dir .. '"')
    vim.cmd ("let $GTAGSDBPATH=" .. '"' .. tags_dir .. '"')
    --vim.cmd [[let $GTAGSROOT="/Users/tony/github/linux/drivers/gpu/drm/virtio"]]
    --vim.cmd [[let $GTAGSDBPATH="/Users/tony/github/linux/drivers/gpu/drm/virtio/.tags_dir"]]

    vim.cmd(
    [[
    set csto=0
    set cst
    set cspc=0
    set cscopequickfix=s0,c0,d0,i0,t0,e0
    set csprg=gtags-cscope
    let g:GtagsCscope_Auto_Load = 1
    let g:GtagsCscope_Auto_Map = 1
    let g:GtagsCscope_Absolute_Path = 1
    ]]
    )

    gtags_updating()
end

function load_gtags(tagsdir)
    local gtags_fp = tagsdir .. '/' .. 'GTAGS'

    if (vim.fn.filereadable(gtags_fp) == 1)
    then
        if (vim.fn.executable('gtags-cscope') == 1)
        then
            printN("[gtags] cs add ".. gtags_fp)
            vim.fn.execute("cs add " .. gtags_fp)
        end
    end
end

function check_tags_eng()
    if (vim.fn.executable('gtags-cscope') == 1)
    then
        return 0
    elseif (vim.fn.executable('cscope') == 1)
    then
        return 0
    end
    printN("cscope and gtags are invaild!");
    return 1
end

tags_dir_name =".tags_dir"
function load_tags()
    if (check_tags_eng() ~= 0) then
        return;
    end

    local maxdepth = 4
    local vimOpenPath = vim.fn.expand('%:p:h')
    -- print('Open Path: ' .. vimOpenPath)
    local i = 0
    local dir = vimOpenPath

    while(i < maxdepth)
    do
        dir = vim.fn.simplify(dir)
        tagsDir = dir .. '/' .. tags_dir_name
        tagsDir = vim.fn.simplify(tagsDir)

        -- find symbols from dir/.tags_dir
        if (vim.fn.isdirectory(tagsDir) == 1)
        then
            printN("Finding tags under: " .. tagsDir)
            if (vim.fn.executable('gtags-cscope') == 1)
            then
                gtags_env_setup(dir, tagsDir)
                load_gtags(tagsDir)
            elseif (vim.fn.executable('cscope') == 1)
            then
                load_cscope(tagsDir)
                load_ctags(tagsDir)
            end
            break;
        -- find symbols form dir. We use gtags as condition.
        elseif (vim.fn.filereadable(dir .. '/GTAGS') == 1)
        then
            printN("Finding tags under " .. dir)
            if (vim.fn.executable('gtags-cscope') == 1)
            then
                gtags_env_setup(dir, dir)
                load_gtags(dir)
            elseif (vim.fn.executable('cscope') == 1)
            then
                load_cscope(dir)
                load_ctags(dir)
            end
            break;
        end

        dir = dir .. '/..'
        i = i + 1
    end
end

load_tags()

return M
