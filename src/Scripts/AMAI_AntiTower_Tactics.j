//==============================================================================
// AMAI Anti-Tower & Air Flank Tactics Enhancer (Pure Native JASS)
// Target: Warcraft III (ROC / TFT / Reforged)
// Features:
//   1. Dynamic scan of enemy base tower density
//   2. Automatic reinforcement: trains Siege & Air units when turtling detected
//   3. Siege Micro: maintains 750-1150 safe range, priority destroys towers
//   4. Air Strike Micro: side-flank pathing to bypass entrance, raids backline workers
//==============================================================================

globals
    constant real    TACTICS_UPDATE_INTERVAL = 2.50
    constant integer TOWER_THRESHOLD         = 3
    
    boolean array    g_PlayerIsTurtling
    timer            g_TacticsTimer
endglobals

function IsTargetAlive takes unit u returns boolean
    return u != null and GetWidgetLife(u) > 0.405
endfunction

function IsUnitDefensiveTower takes unit u returns boolean
    local integer id = GetUnitTypeId(u)
    
    // Human
    if id == 'hwtw' or id == 'hgtw' or id == 'hctw' or id == 'hatw' then
        return true
    endif
    // Orc
    if id == 'owtt' or id == 'oovw' then
        return true
    endif
    // Undead
    if id == 'uzsp' or id == 'uznp' or id == 'uzig' then
        return true
    endif
    // Night Elf
    if id == 'etrp' then
        return true
    endif
    return false
endfunction

function IsUnitSiegeWeapon takes unit u returns boolean
    local integer id = GetUnitTypeId(u)
    if id == 'hmtm' or id == 'hmtt' then
        return true
    endif
    if id == 'ocat' then
        return true
    endif
    if id == 'umtw' then
        return true
    endif
    if id == 'ebal' then
        return true
    endif
    return false
endfunction

function IsUnitAirStrike takes unit u returns boolean
    local integer id = GetUnitTypeId(u)
    if id == 'hgyr' or id == 'hgry' or id == 'hdhw' then
        return true
    endif
    if id == 'owyv' or id == 'otbr' then
        return true
    endif
    if id == 'ugar' or id == 'ubsl' or id == 'ufro' then
        return true
    endif
    if id == 'ehip' or id == 'ehpr' or id == 'efdr' or id == 'echm' then
        return true
    endif
    return false
endfunction

function ScanPlayerTowerDefense takes player targetPlayer returns boolean
    local group g = CreateGroup()
    local unit u = null
    local integer count = 0
    local real bx = GetPlayerStartLocationX(targetPlayer)
    local real by = GetPlayerStartLocationY(targetPlayer)
    
    call GroupEnumUnitsInRange(g, bx, by, 2500.0, null)
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        if GetOwningPlayer(u) == targetPlayer and IsTargetAlive(u) and IsUnitDefensiveTower(u) then
            set count = count + 1
        endif
        call GroupRemoveUnit(g, u)
    endloop
    call DestroyGroup(g)
    set g = null
    
    return (count >= TOWER_THRESHOLD)
endfunction

function ReinforceAntiTowerUnits takes player aiPlayer returns nothing
    local group bGroup = CreateGroup()
    local unit b = null
    local integer bId = 0
    local integer gold = GetPlayerState(aiPlayer, PLAYER_STATE_RESOURCE_GOLD)
    local integer wood = GetPlayerState(aiPlayer, PLAYER_STATE_RESOURCE_LUMBER)
    
    if gold < 250 or wood < 100 then
        call DestroyGroup(bGroup)
        set bGroup = null
        return
    endif
    
    call GroupEnumUnitsOfPlayer(bGroup, aiPlayer, null)
    loop
        set b = FirstOfGroup(bGroup)
        exitwhen b == null
        if IsTargetAlive(b) and IsUnitType(b, UNIT_TYPE_STRUCTURE) then
            set bId = GetUnitTypeId(b)
            // Human Workshop -> Train Mortar
            if bId == 'harm' then
                call IssueImmediateOrderById(b, 'hmtm')
            // Human Aviary -> Train Gryphon
            elseif bId == 'hgra' then
                call IssueImmediateOrderById(b, 'hgry')
            // Orc Barracks -> Train Catapult
            elseif bId == 'obar' then
                call IssueImmediateOrderById(b, 'ocat')
            // Orc Beastiary -> Train Wind Rider
            elseif bId == 'obea' then
                call IssueImmediateOrderById(b, 'owyv')
            // Undead Slaughterhouse -> Train Meat Wagon
            elseif bId == 'uslh' then
                call IssueImmediateOrderById(b, 'umtw')
            // Undead Crypt -> Train Gargoyle
            elseif bId == 'usep' then
                call IssueImmediateOrderById(b, 'ugar')
            // Night Elf Ancient of War -> Train Glaive Thrower
            elseif bId == 'eaow' then
                call IssueImmediateOrderById(b, 'ebal')
            endif
        endif
        call GroupRemoveUnit(bGroup, b)
    endloop
    call DestroyGroup(bGroup)
    set bGroup = null
endfunction

function ExecuteSiegeTactics takes player aiPlayer, player targetPlayer returns nothing
    local group g = CreateGroup()
    local group enemyTowers = CreateGroup()
    local unit siegeUnit = null
    local unit targetTower = null
    local unit tempUnit = null
    local real minDistance = 99999.0
    local real dist = 0.0
    local real sx = 0.0
    local real sy = 0.0
    local real tx = 0.0
    local real ty = 0.0
    
    call GroupEnumUnitsOfPlayer(g, aiPlayer, null)
    
    loop
        set siegeUnit = FirstOfGroup(g)
        exitwhen siegeUnit == null
        
        if IsTargetAlive(siegeUnit) and IsUnitSiegeWeapon(siegeUnit) then
            set sx = GetUnitX(siegeUnit)
            set sy = GetUnitY(siegeUnit)
            set targetTower = null
            set minDistance = 99999.0
            
            call GroupEnumUnitsInRange(enemyTowers, sx, sy, 1400.0, null)
            loop
                set tempUnit = FirstOfGroup(enemyTowers)
                exitwhen tempUnit == null
                if GetOwningPlayer(tempUnit) == targetPlayer and IsTargetAlive(tempUnit) and IsUnitDefensiveTower(tempUnit) then
                    set dist = SquareRoot((GetUnitX(tempUnit) - sx) * (GetUnitX(tempUnit) - sx) + (GetUnitY(tempUnit) - sy) * (GetUnitY(tempUnit) - sy))
                    if dist < minDistance then
                        set minDistance = dist
                        set targetTower = tempUnit
                    endif
                endif
                call GroupRemoveUnit(enemyTowers, tempUnit)
            endloop
            
            if targetTower != null then
                // If within 700 range of tower, retreat to safe distance
                if minDistance < 700.0 then
                    set tx = sx - (GetUnitX(targetTower) - sx) * 0.5
                    set ty = sy - (GetUnitY(targetTower) - sy) * 0.5
                    call IssuePointOrder(siegeUnit, "move", tx, ty)
                else
                    // Safely snipe tower from max range
                    call IssueTargetOrder(siegeUnit, "attack", targetTower)
                endif
            endif
        endif
        
        call GroupRemoveUnit(g, siegeUnit)
    endloop
    
    call DestroyGroup(g)
    call DestroyGroup(enemyTowers)
    set g = null
    set enemyTowers = null
endfunction

function ExecuteAirFlankTactics takes player aiPlayer, player targetPlayer returns nothing
    local group airGroup = CreateGroup()
    local group enemyWorkers = CreateGroup()
    local unit airUnit = null
    local unit worker = null
    local unit targetWorker = null
    local real bx = GetPlayerStartLocationX(targetPlayer)
    local real by = GetPlayerStartLocationY(targetPlayer)
    local real ax = GetPlayerStartLocationX(aiPlayer)
    local real ay = GetPlayerStartLocationY(aiPlayer)
    local real midX = (ax + bx) * 0.5
    local real midY = (ay + by) * 0.5
    local real dirX = -(by - ay)
    local real dirY =  (bx - ax)
    local real len = SquareRoot(dirX * dirX + dirY * dirY)
    local real flankX = 0.0
    local real flankY = 0.0
    
    if len > 0.1 then
        set flankX = midX + (dirX / len) * 2400.0
        set flankY = midY + (dirY / len) * 2400.0
    else
        set flankX = midX
        set flankY = midY
    endif
    
    call GroupEnumUnitsInRange(enemyWorkers, bx, by, 1400.0, null)
    set targetWorker = null
    loop
        set worker = FirstOfGroup(enemyWorkers)
        exitwhen worker == null
        if GetOwningPlayer(worker) == targetPlayer and IsTargetAlive(worker) and IsUnitType(worker, UNIT_TYPE_PEON) then
            set targetWorker = worker
        endif
        call GroupRemoveUnit(enemyWorkers, worker)
    endloop
    call DestroyGroup(enemyWorkers)
    set enemyWorkers = null
    
    call GroupEnumUnitsOfPlayer(airGroup, aiPlayer, null)
    loop
        set airUnit = FirstOfGroup(airGroup)
        exitwhen airUnit == null
        
        if IsTargetAlive(airUnit) and IsUnitAirStrike(airUnit) then
            if (GetUnitState(airUnit, UNIT_STATE_LIFE) / GetUnitState(airUnit, UNIT_STATE_MAX_LIFE)) < 0.30 then
                call IssuePointOrder(airUnit, "move", ax, ay)
            else
                // If reached near backline, strike workers or town center
                if SquareRoot((GetUnitX(airUnit) - bx) * (GetUnitX(airUnit) - bx) + (GetUnitY(airUnit) - by) * (GetUnitY(airUnit) - by)) < 1600.0 then
                    if targetWorker != null then
                        call IssueTargetOrder(airUnit, "attack", targetWorker)
                    else
                        call IssuePointOrder(airUnit, "attack", bx, by)
                    endif
                else
                    // Move via side-flank coordinates to avoid front gate
                    call IssuePointOrder(airUnit, "move", flankX, flankY)
                endif
            endif
        endif
        
        call GroupRemoveUnit(airGroup, airUnit)
    endloop
    call DestroyGroup(airGroup)
    set airGroup = null
endfunction

function TacticsTimerCallback takes nothing returns nothing
    local integer i = 0
    local integer j = 0
    local player pAI = null
    local player pEnemy = null
    
    set i = 0
    loop
        exitwhen i > 11
        set pAI = Player(i)
        
        if GetPlayerController(pAI) == MAP_CONTROL_COMPUTER and GetPlayerSlotState(pAI) == PLAYER_SLOT_STATE_PLAYING then
            set j = 0
            loop
                exitwhen j > 11
                set pEnemy = Player(j)
                if pEnemy != pAI and IsPlayerEnemy(pAI, pEnemy) and GetPlayerSlotState(pEnemy) == PLAYER_SLOT_STATE_PLAYING then
                    set g_PlayerIsTurtling[j] = ScanPlayerTowerDefense(pEnemy)
                    
                    if g_PlayerIsTurtling[j] then
                        // 1. Order AI production buildings to reinforce siege and air
                        call ReinforceAntiTowerUnits(pAI)
                        // 2. Micro siege weapons to kite and focus towers
                        call ExecuteSiegeTactics(pAI, pEnemy)
                        // 3. Order air units to flank around front entrance and strike backline
                        call ExecuteAirFlankTactics(pAI, pEnemy)
                    endif
                endif
                set j = j + 1
            endloop
        endif
        
        set i = i + 1
    endloop
endfunction

function Init_AntiTowerTactics takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen i > 11
        set g_PlayerIsTurtling[i] = false
        set i = i + 1
    endloop
    
    set g_TacticsTimer = CreateTimer()
    call TimerStart(g_TacticsTimer, TACTICS_UPDATE_INTERVAL, true, function TacticsTimerCallback)
endfunction
